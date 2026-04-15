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

## Using This Template

1. Click **Use this template** on the GitHub repository page and choose **Create a new repository**.
2. Name your repository. Use `yourusername.github.io` if you want the site at your root GitHub Pages domain; use any other name for a project page at `https://yourusername.github.io/your-repo-name/`.
3. Set visibility to **Public** (required for GitHub Pages on free accounts).
4. Click **Create repository from template**.
5. Clone your new repo, open it in VS Code, and run **Dev Containers: Reopen in Container**.
6. Customize `src/routes/+page.svelte`, the page title and description, and `static/favicon.png`.
7. Push to `main`. The deploy workflow runs automatically, enables GitHub Pages, and publishes your site.

## Recommended Setup

1. Click `Use this template` on GitHub to create your own repository.
2. Clone your new repository.
3. Open the folder in VS Code.
4. Run `Dev Containers: Reopen in Container`.
5. Wait for the container setup to finish.
6. Open the forwarded app port in your browser when prompted.

If port `5173` is already in use, the dev startup script automatically selects the next available port. Use the VS Code Ports tab to open the running site.

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
