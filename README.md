# SvelteKit + Tailwind GitHub Pages Template

This repository is a GitHub template for building and publishing a static site with SvelteKit, Tailwind CSS, VS Code Dev Containers, and GitHub Pages.

It is designed to be forked, renamed, and repurposed without carrying forward workshop branding or repo-specific deployment assumptions.

Created by Bill Raymond, owner of [Cambermast LLC](https://cambermast.com), with the tagline `AI Agility in Action`.

## What This Template Includes

- SvelteKit with the static adapter configured for GitHub Pages
- Svelte 5, Tailwind CSS 4, Vite, and Node 22
- a VS Code Dev Container workflow for consistent local development
- a dedicated CI workflow for build and type-check validation on branches and pull requests
- GitHub Actions deployment to GitHub Pages
- dynamic dev-port fallback behavior that works well in VS Code and containers

## One-Time Setup

### 1. Create your repository from the template

1. Click **Use this template** at the top of this GitHub repository page.
2. Choose **Create a new repository**.
3. Name your repository.
   - Use `yourusername.github.io` to publish at `https://yourusername.github.io/`.
   - Use any other name to publish at `https://yourusername.github.io/your-repo-name/`.
4. Set visibility to **Public** (required for GitHub Pages on free accounts).
5. Click **Create repository from template**.

### 2. Enable GitHub Pages

1. In your new repository on GitHub, click **Settings**.
2. In the left sidebar, click **Pages**.
3. Under **Source**, select **GitHub Actions**.
4. Click **Save**.

### 3. Clone the repository

```sh
git clone https://github.com/yourusername/your-repo-name.git
cd your-repo-name
```

### 4. Open in VS Code with the Dev Container

1. Open VS Code.
2. If prompted, install the [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers).
3. Open the cloned folder: **File → Open Folder**.
4. When VS Code prompts to reopen in a container, click **Reopen in Container**. If the prompt does not appear, open the Command Palette (`Ctrl+Shift+P` / `Cmd+Shift+P`) and run **Dev Containers: Reopen in Container**.
5. Wait for the container to build and the dev server to start. This may take a few minutes on the first run.
6. When the forwarded port notification appears, click **Open in Browser** to view the running site. If you miss the prompt, open the **Ports** tab in the VS Code panel and click the globe icon next to the forwarded port.

If port `5173` is already in use, the dev startup script automatically selects the next available port.

### 5. Deploy your site

Push any commit to `main` to trigger the deploy workflow. Your site will be live at the GitHub Pages URL shown in **Settings → Pages** after the workflow completes.

## Deployment Model

This template is intended for static-site deployment on GitHub Pages.

- `@sveltejs/adapter-static` is the production adapter
- `.github/workflows/deploy-pages.yml` builds and deploys the site to GitHub Pages
- the workflow automatically sets `BASE_PATH` so both project pages and user/organization pages work correctly

## After Using This Template

- Remove or replace the attribution line near the top of this README.
- Replace the starter page, metadata, social metadata, images, and favicon with your own before launch.
- Update the package metadata only if you want a different package name than the neutral default.
- Keep the included MIT license if it fits your project, or replace it with a different license if your needs differ.

## Local Commands

```sh
npm install
npm run dev
npm run build
npm run check
```

If you want to build and run the dev image directly outside VS Code:

```sh
npm run docker:dev:build
npm run docker:dev:run
```

## Troubleshooting

- Make sure Docker Desktop is running before reopening in the container.
- The first container build can take a few minutes.
- If you do not see the running site, check the VS Code Ports view.
- If the container gets into a bad state, try `Dev Containers: Rebuild Container`.
- Manual deploys are available through the `Deploy to GitHub Pages` workflow if you want to publish before your first push to the default branch.

## Technical Notes

More setup details are in [TECHNICAL_SETUP.md](./TECHNICAL_SETUP.md).
