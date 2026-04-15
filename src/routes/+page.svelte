<svelte:head>
	<title>Start Here | SvelteKit Tailwind Pages Template</title>
	<meta
		name="description"
		content="Start from a neutral SvelteKit and Tailwind CSS template that is ready for GitHub Pages."
	/>
</svelte:head>

<script lang="ts">
	const commands = ['npm install', 'npm run dev', 'npm run check', 'npm run build'];
</script>

<div class="min-h-screen bg-stone-50 text-stone-900">
	<div class="mx-auto flex max-w-5xl flex-col gap-12 px-6 py-16 sm:px-10 lg:px-12">
		<section class="grid gap-6 lg:grid-cols-[minmax(0,1.5fr)_minmax(18rem,1fr)] lg:items-end">
			<div class="space-y-5">
				<p class="text-sm font-semibold uppercase tracking-[0.22em] text-teal-700">
					SvelteKit + Tailwind + GitHub Pages
				</p>
				<h1 class="max-w-3xl text-4xl font-semibold tracking-tight text-balance sm:text-5xl">
					A neutral starter template you can fork, rename, and publish without cleanup first.
				</h1>
				<p class="max-w-2xl text-lg leading-8 text-stone-700">
					Replace this page with your content, keep the deployment workflow, and use the included
					dev container and Docker helpers if they fit your setup.
				</p>
			</div>

			<div class="rounded-3xl border border-stone-200 bg-white p-6 shadow-sm">
				<p class="text-sm font-semibold text-stone-900">What ships in the template</p>
				<ul class="mt-4 space-y-3 text-sm leading-6 text-stone-700">
					<li>Static-site output with `@sveltejs/adapter-static`</li>
					<li>Tailwind CSS 4 and Svelte 5 ready to customize</li>
					<li>GitHub Pages deployment with base-path handling</li>
					<li>Optional VS Code Dev Container and local Docker scripts</li>
				</ul>
			</div>
		</section>

		<section class="grid gap-6 md:grid-cols-2">
			<div class="rounded-3xl bg-stone-900 p-6 text-stone-100 shadow-sm">
				<p class="text-sm font-semibold uppercase tracking-[0.18em] text-teal-300">Quick start</p>
				<ul class="mt-4 space-y-3 font-mono text-sm">
					{#each commands as command}
						<li>{command}</li>
					{/each}
				</ul>
			</div>

			<div class="rounded-3xl border border-stone-200 bg-white p-6 shadow-sm">
				<p class="text-sm font-semibold uppercase tracking-[0.18em] text-stone-500">
					Next steps
				</p>
				<ul class="mt-4 space-y-3 text-sm leading-6 text-stone-700">
					<li>Update the site title, description, favicon, and social metadata.</li>
					<li>Replace this starter page with your own routes and components.</li>
					<li>Enable GitHub Pages in Settings → Pages → Source: GitHub Actions, then push to main.</li>
				</ul>
			</div>
		</section>
	</div>
</div>
