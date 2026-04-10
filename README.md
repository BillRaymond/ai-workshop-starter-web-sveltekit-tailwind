# SvelteKit Dev Container

This repository contains the default SvelteKit starter scaffolded with the current Svelte CLI, TypeScript, and Tailwind CSS using the official Tailwind Vite plugin integration.

## Stack

- SvelteKit
- Svelte 5
- Tailwind CSS 4
- npm
- VS Code Dev Containers

## Open In The Dev Container

1. Open the folder in VS Code.
2. Run `Dev Containers: Reopen in Container`.
3. Wait for the container lifecycle hooks to finish.

The Dev Container will:

- install dependencies with `npm install`
- sync your host `~/.gitconfig` into the container
- preserve any existing container `user.name` and `user.email`
- start one detached SvelteKit dev server
- forward the running app port and open it in the browser when VS Code forwards it

## Development

The app follows standard SvelteKit commands:

```sh
npm run dev
npm run build
npm run preview
npm run check
```

The container startup script prefers port `5173`. If that port is already in use in the container, it automatically selects the next available port and prints the actual port.

## Notes

- The default SvelteKit starter content has not been replaced.
- Vite is configured to listen on `0.0.0.0` so the app is reachable from the host through VS Code port forwarding.
