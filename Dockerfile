FROM mcr.microsoft.com/devcontainers/javascript-node:1-22-bookworm AS base

WORKDIR /workspace

ENV npm_config_update_notifier=false

FROM base AS dev

USER node

FROM base AS build

COPY package.json package-lock.json ./
RUN npm install

COPY . .
RUN npm run build

FROM node:22-bookworm-slim AS prod

WORKDIR /app

ENV NODE_ENV=production
ENV HOST=0.0.0.0
ENV PORT=3000

COPY package.json package-lock.json ./
RUN npm install --omit=dev --ignore-scripts && npm cache clean --force

COPY --from=build /workspace/build ./build

EXPOSE 3000

CMD ["node", "build"]
