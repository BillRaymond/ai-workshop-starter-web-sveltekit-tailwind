# Technical Setup

This repository is a neutral SvelteKit starter built for a simple workshop workflow. Students can create a new repository from the template, open it in VS Code, and work inside a Dev Container on Windows, macOS, or Linux.

## Stack

- Node 22
- SvelteKit
- Svelte 5
- `@sveltejs/adapter-static`
- Tailwind CSS 4
- Vite
- npm
- VS Code Dev Containers
- Docker Desktop or Docker Engine for local development
- GitHub Pages deployment through GitHub Actions

## What This Template Is For

This template is designed for:

- static SvelteKit websites
- local development in VS Code Dev Containers
- publishing to GitHub Pages
- beginner-friendly workshop use

This template is not intended for:

- server-side hosting
- long-running backend services
- production Docker deployment

## Dev Container Design

The Dev Container is intended to give students a consistent development environment across operating systems.

The container should:

- build from the root `Dockerfile`
- use the `dev` target
- run as the `node` user
- install dependencies with `npm install`
- start the local dev server automatically
- forward the SvelteKit development port in VS Code

The Dev Container should not manually mount the host `.gitconfig` file.

VS Code Dev Containers already provide built-in support for reusing local Git configuration and credentials inside the container.

## Required Dev Container Configuration

Your `.devcontainer/devcontainer.json` should follow this pattern:

```json
{
  "name": "SvelteKit Template Dev Container",
  "build": {
    "dockerfile": "../Dockerfile",
    "target": "dev"
  },
  "remoteUser": "node",
  "updateContentCommand": "npm install",
  "postStartCommand": "bash .devcontainer/scripts/start-dev-server.sh",
  "postAttachCommand": "bash .devcontainer/scripts/start-dev-server.sh",
  "waitFor": "postStartCommand",
  "forwardPorts": [5173],
  "portsAttributes": {
    "5173": {
      "label": "SvelteKit dev server",
      "onAutoForward": "openBrowser",
      "requireLocalPort": false
    },
    "5174-5190": {
      "label": "SvelteKit dev server",
      "onAutoForward": "openBrowser",
      "requireLocalPort": false
    }
  },
  "customizations": {
    "vscode": {
      "extensions": [
        "svelte.svelte-vscode",
        "bradlc.vscode-tailwindcss",
        "ms-vscode-remote.remote-containers"
      ]
    }
  }
}
