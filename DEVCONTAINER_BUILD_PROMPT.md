# Deterministic VS Code Dev Container Build Prompt

This environment was originally created from the prompt below, then refined through additional prompts and iteration in ChatGPT and Claude until it was ready for use.

This document is included for reference only and is not required in order to use this environment.

# Prompt
You are building a complete, ready-to-run SvelteKit development environment in a VS Code Dev Container. Do not ask clarifying questions. Follow this specification exactly. Recreate the working repository pattern described here instead of inventing a different container architecture.

## Editable Defaults

Update these values first when customizing the build:

- VS Code extension IDs:
  - `anthropic.claude-code`
  - `openai.chatgpt`
- Container image tag: `mcr.microsoft.com/devcontainers/javascript-node:1-22-bookworm`
- OS / distro: Debian Bookworm
- Node version: 22 LTS
- Package manager: `npm`
- Frontend framework: SvelteKit, latest stable
- Styling framework: Tailwind CSS, latest stable version compatible with the selected SvelteKit version
- Preferred dev port: `5173`
- Fallback dev port range: `5174-5190`
- Production runtime port: `3000`

## Non-Negotiable Requirements

- Do not ask questions.
- Use a root `Dockerfile` as the single source of truth for both development and production.
- Do not use only the `image` property in `devcontainer.json`. The Dev Container must build from the root `Dockerfile`.
- The root `Dockerfile` must define at least these stages:
  - `dev`
  - `build`
  - `prod`
- The `dev` stage must support VS Code Dev Containers.
- The `build` stage must produce the production-ready SvelteKit build output.
- The `prod` stage must run the built app as a production container.
- The setup is incomplete if either development or production behavior fails.
- Default to `mcr.microsoft.com/devcontainers/javascript-node:1-22-bookworm`.
- Do not switch the default image to `mcr.microsoft.com/devcontainers/javascript-node:22-bookworm`.
- Treat `1-22-bookworm` as the preferred default because it is more deterministic: it pins the Dev Container image major line while still using Node 22 on Debian Bookworm.
- Use only the VS Code extensions listed in the editable defaults.
- Initialize a SvelteKit project using the latest stable version.
- Configure Tailwind CSS using the current supported integration approach for that SvelteKit version.
- Install dependencies with `npm`.
- Do not replace or rewrite the default SvelteKit starter page or starter content.
- Configure Vite and SvelteKit development behavior to listen on `0.0.0.0`.
- Keep Vite configured with `strictPort: false`.
- Preserve the current port-switching behavior so development can fall back if `5173` is unavailable.
- Configure Git inside the container to inherit from the local computer where applicable.
- If the host `~/.gitconfig` is available, mount it into the container and include it in the container's global Git configuration.
- Do not overwrite existing in-container `git config --global user.name` or `git config --global user.email` values if they are already set.

## Required Files

Produce all required files and do not leave any step incomplete:

- `.devcontainer/devcontainer.json`
- `Dockerfile` at the repository root
- `.devcontainer/scripts/configure-git.sh`
- `.devcontainer/scripts/start-dev-server.sh`
- SvelteKit project files
- `README.md`
- `.gitignore`

## Required Dev Container Configuration

The Dev Container configuration must include these settings or exact equivalent behavior:

- `.devcontainer/devcontainer.json` must use:
  - `build.dockerfile` pointing to `../Dockerfile`
  - `target` set to `dev`
  - `remoteUser` set to `node`
- `updateContentCommand` must run `npm install`.
- `postCreateCommand` must run the Git configuration script.
- `postStartCommand` must run the dev-server startup script.
- `postAttachCommand` must run the same dev-server startup script.
- `waitFor` should wait for startup completion so the environment is ready when the container opens.
- `forwardPorts` must include `5173`.
- `portsAttributes` must cover:
  - port `5173`
  - the fallback range `5174-5190`
- Port attributes must:
  - label the app clearly
  - auto-forward ports
  - open the browser automatically when the app is ready
  - allow fallback local port usage if `5173` is not available

## Required Dev Startup Behavior

The startup flow must be reliable and repeat-safe:

- Use a dedicated lifecycle script for the dev server.
- Start the dev server from both `postStartCommand` and `postAttachCommand`.
- Launch the dev server in a detached way so it survives the lifecycle hook shell.
- Prevent duplicate Vite processes when the container is reopened or reattached.
- Store runtime state such as PID, selected port, and log output in a Dev Container state directory.
- Prefer port `5173`.
- If `5173` is unavailable inside the container, automatically choose the next available port through `5190`.
- Start Vite with `--host 0.0.0.0`.
- Print a clear startup message that includes the actual selected port and tells the user how to find the VS Code Ports view.
- The message must be equivalent in meaning to:

```text
SvelteKit dev server is running in the container on port <port>.
To access the site in your computer's browser, go to the Visual Studio Code Ports list.
If you do not see the Ports list, press Command or Control+Shift+P and type:
Ports: Focus on Ports View
```

## Required Production Behavior

Production readiness is mandatory:

- The root `Dockerfile` must support building a production image without relying on Dev Container lifecycle hooks.
- `npm run build` must succeed.
- The `build` stage must produce the production-ready app.
- The `prod` stage must run the built SvelteKit app.
- Production must listen on `0.0.0.0`.
- Production must use a stable runtime port, defaulting to `3000`.
- The production image must not depend on development-only scripts, detached startup hooks, or VS Code-specific behavior.

## `.gitignore` Requirements

Create a `.gitignore` that excludes:

- `node_modules`
- build output
- logs
- caches
- environment files
- SvelteKit artifacts
- Vite artifacts
- Tailwind artifacts where applicable
- coverage output
- common web-tool build artifacts
- Dev Container runtime state
- OS-specific files for macOS, Linux, and Windows such as `.DS_Store`

The `.gitignore` must work for both local development and container use. Do not attempt to configure or modify any operating system.

## Validation

Validate all three areas: development, production, and Git behavior.

### Development Validation

- The Dev Container builds successfully from the root `Dockerfile`.
- `npm install` completes successfully in the container.
- The default SvelteKit starter page renders correctly.
- Vite listens on `0.0.0.0`.
- Port `5173` is used when available.
- The next available port is selected automatically when `5173` is already in use.
- The printed startup message reports the actual running port.
- Reopening or reattaching the Dev Container does not start duplicate dev servers.
- Hot module reload works after a file change.

### Production Validation

- `npm run build` succeeds.
- The production container image builds successfully from the root `Dockerfile`.
- The production container starts successfully from the `prod` stage.
- The compiled app is reachable on the production port.
- Production does not depend on Dev Container lifecycle scripts.
- Development-only behavior does not leak into the production image.

### Git Validation

- Host `~/.gitconfig` is included when available.
- Existing in-container `user.name` and `user.email` are not clobbered.
- Git is initialized only if the folder is not already a Git repository.
- Existing repository history is not replaced, reset, or rewritten.
- A commit is created only after required generation and validation steps succeed.

## Git Finalization

After all required files are generated and all validation steps pass:

- If the folder is not already a Git repository, run `git init`.
- If the folder is already a Git repository, do not reinitialize it.
- Stage the generated files.
- Create an initial commit if one does not yet exist, or create a normal new commit if the repository already exists and committing generated work is part of the task.
- Do not rewrite existing history.
- Do not use destructive Git commands.

## Completion Definition

The task is complete only when all of the following are true:

- The Dev Container is ready for daily development in VS Code.
- The same root `Dockerfile` is ready for production release builds.
- Git configuration inside the container inherits from the local computer where applicable.
- Port `5173` is preferred and fallback ports work without collisions.
- The generated environment matches standard SvelteKit conventions.
- All required files exist.
- Validation has passed for development, production, and Git behavior.
- The repository has been committed safely without overwriting existing history.
