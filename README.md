# SvelteKit Dev Container And Docker Deployment

This repository contains the default SvelteKit starter scaffolded with the current Svelte CLI, TypeScript, and Tailwind CSS using the official Tailwind Vite plugin integration. The project now uses a shared multi-stage `Dockerfile` for both VS Code Dev Containers and generic OCI/Docker deployment.

## Stack

- SvelteKit
- Svelte 5
- Tailwind CSS 4
- npm
- VS Code Dev Containers
- Docker / OCI image deployment

## Open In The Dev Container

1. Open the folder in VS Code.
2. Run `Dev Containers: Reopen in Container`.
3. Wait for the container lifecycle hooks to finish.

The Dev Container will:

- build the `dev` target from the root `Dockerfile`
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

The dev container startup script prefers port `5173`. If that port is already in use in the container, it automatically selects the next available port and prints the actual port.

## Docker

Build and run the development container image directly:

```sh
npm run docker:dev:build
npm run docker:dev:run
```

The standalone Docker dev runner prefers host port `5173`. If that port is already in use on your computer, it automatically selects the next available port up to `5190` and starts Vite on that same port inside the container.

Build and run the production image locally:

```sh
npm run docker:prod:build
npm run docker:prod:run
```

The production container serves the SvelteKit app through `@sveltejs/adapter-node` and listens on `HOST=0.0.0.0` and `PORT=3000` by default.

## Notes

- The default SvelteKit starter content has not been replaced.
- Vite is configured to listen on `0.0.0.0` so the app is reachable from the host through VS Code port forwarding.
- The root `Dockerfile` is the shared source of truth for both the devcontainer and generic container deployment.
