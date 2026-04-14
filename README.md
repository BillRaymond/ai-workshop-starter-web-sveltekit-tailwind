# AI Workshop: Code and Automate with AI

This repository is a starter environment for the Cambermast course [AI Workshop: Code and Automate with AI](https://www.cambermast.com/training/ai-workshop-code-and-automate-with-ai).

It is set up so you can get started quickly with a consistent development environment using VS Code Dev Containers. The goal is to reduce setup problems and give everyone the same starting point.

## What This Includes

Everything you need to start building a website from scratch, including:

- a modern frontend web stack built with SvelteKit, Svelte 5, Tailwind CSS 4, and Node 22
- a SvelteKit project starter
- npm for package management
- a VS Code Dev Container for a consistent development environment
- Docker-based setup for local development and deployment
- Git-friendly project structure for saving and sharing your work

## Recommended Setup

1. Clone this repository.
2. Open the folder in VS Code.
3. Run `Dev Containers: Reopen in Container`.
4. Wait for the container setup to finish.
5. Open the forwarded app port in your browser when prompted.

## Troubleshooting

- Make sure Docker Desktop is running before reopening in the container.
- The first container build can take a few minutes.
- If you do not see the running site, check the VS Code Ports view.
- If the container gets into a bad state, try `Dev Containers: Rebuild Container`.

## Technical Details

- Technical setup and container implementation notes are in [TECHNICAL_SETUP.md](./TECHNICAL_SETUP.md).
- This environment was originally built from a prompt, then refined through additional prompting and iteration.
- You can review that original prompt used to create the structure for this environment in [DEVCONTAINER_BUILD_PROMPT.md](./DEVCONTAINER_BUILD_PROMPT.md).
