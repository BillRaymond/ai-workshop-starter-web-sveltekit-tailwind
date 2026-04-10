#!/usr/bin/env bash

set -euo pipefail

host_gitconfig="/tmp/local-user.gitconfig"

if [[ ! -f "$host_gitconfig" ]]; then
	exit 0
fi

current_name="$(git config --global user.name || true)"
current_email="$(git config --global user.email || true)"

if ! git config --global --get-all include.path | grep -Fxq "$host_gitconfig"; then
	git config --global --add include.path "$host_gitconfig"
fi

if [[ -n "$current_name" ]]; then
	git config --global user.name "$current_name"
fi

if [[ -n "$current_email" ]]; then
	git config --global user.email "$current_email"
fi
