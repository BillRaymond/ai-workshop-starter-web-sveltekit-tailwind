#!/usr/bin/env bash

set -euo pipefail

script_dir="$(cd -- "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
workspace_dir="$(cd -- "$script_dir/../.." && pwd)"
state_dir="$workspace_dir/.devcontainer/.state"
pid_file="$state_dir/dev-server.pid"
port_file="$state_dir/dev-server.port"
log_file="$state_dir/dev-server.log"
preferred_port=5173
max_port=5190

mkdir -p "$state_dir"

print_status() {
	local port="$1"
	printf 'SvelteKit dev server is running in the container on port %s.\n' "$port"
	printf "To access the site in your computer's browser, go to the Visual Studio Code Ports list.\n"
	printf 'If you do not see the Ports list, press Command or Control+Shift+P and type:\n'
	printf 'Ports: Focus on Ports View\n'
}

port_is_listening() {
	local port="$1"
	node - "$port" <<'NODE'
const net = require('node:net');
const port = Number(process.argv[2]);

const socket = net.connect({ host: '127.0.0.1', port });
let finished = false;

const done = (ok) => {
	if (finished) return;
	finished = true;
	socket.destroy();
	process.exit(ok ? 0 : 1);
};

socket.setTimeout(500);
socket.once('connect', () => done(true));
socket.once('timeout', () => done(false));
socket.once('error', () => done(false));
NODE
}

find_available_port() {
	node - "$preferred_port" "$max_port" <<'NODE'
const net = require('node:net');
const preferred = Number(process.argv[2]);
const max = Number(process.argv[3]);
const hosts = ['127.0.0.1', '0.0.0.0'];

const canBind = (port, index, done) => {
	if (index >= hosts.length) {
		done(true);
		return;
	}

	const server = net.createServer();
	server.unref();
	server.once('error', () => done(false));
	server.listen({ host: hosts[index], port }, () => {
		server.close(() => canBind(port, index + 1, done));
	});
};

const tryPort = (port) => {
	if (port > max) {
		process.exit(1);
	}

	canBind(port, 0, (available) => {
		if (available) {
			console.log(port);
			return;
		}

		tryPort(port + 1);
	});
};

tryPort(preferred);
NODE
}

command_matches() {
	local pid="$1"
	ps -p "$pid" -o command= | grep -Fq "$workspace_dir/node_modules/.bin/vite dev"
}

ensure_dependencies() {
	local needs_install=0
	local needs_repair=0

	if [[ ! -d "$workspace_dir/node_modules" ]]; then
		needs_install=1
	fi

	if [[ ! -x "$workspace_dir/node_modules/.bin/vite" ]]; then
		needs_install=1
	fi

	# We've seen interrupted installs leave @sveltejs/kit half-extracted, which
	# breaks the devcontainer open flow because Vite exits during postStart.
	if [[ ! -f "$workspace_dir/node_modules/@sveltejs/kit/src/cli.js" ]]; then
		needs_repair=1
	fi

	if [[ ! -f "$workspace_dir/node_modules/@sveltejs/kit/src/utils/filesystem.js" ]]; then
		needs_repair=1
	fi

	if [[ "$needs_repair" -eq 1 ]]; then
		echo "Detected an incomplete SvelteKit install. Repairing dependencies..." >&2
		npm --prefix "$workspace_dir" install --force
	elif [[ "$needs_install" -eq 1 ]]; then
		npm --prefix "$workspace_dir" install
	fi
}

ensure_dependencies
bash "$script_dir/configure-git.sh"

if [[ -f "$pid_file" && -f "$port_file" ]]; then
	current_pid="$(cat "$pid_file")"
	current_port="$(cat "$port_file")"

	if kill -0 "$current_pid" >/dev/null 2>&1 && command_matches "$current_pid" && port_is_listening "$current_port"; then
		print_status "$current_port"
		exit 0
	fi
fi

rm -f "$pid_file" "$port_file"

if ! port="$(find_available_port)"; then
	echo "Unable to find an open port between $preferred_port and $max_port." >&2
	exit 1
fi

touch "$log_file"
launch_command="cd '$workspace_dir'; echo \$\$ > '$pid_file'; exec '$workspace_dir/node_modules/.bin/vite' dev --host 0.0.0.0 --port '$port'"

if command -v setsid >/dev/null 2>&1; then
	setsid bash -lc "$launch_command" >>"$log_file" 2>&1 < /dev/null &
else
	nohup bash -lc "$launch_command" >>"$log_file" 2>&1 < /dev/null &
fi

for _ in $(seq 1 10); do
	if [[ -f "$pid_file" ]]; then
		break
	fi
	sleep 1
done

if [[ ! -f "$pid_file" ]]; then
	echo "SvelteKit dev server failed to record its process id." >&2
	exit 1
fi

pid="$(cat "$pid_file")"
echo "$port" >"$port_file"

for _ in $(seq 1 60); do
	if kill -0 "$pid" >/dev/null 2>&1 && port_is_listening "$port"; then
		print_status "$port"
		exit 0
	fi
	sleep 1
done

echo "SvelteKit dev server failed to start. See $log_file for details." >&2
exit 1
