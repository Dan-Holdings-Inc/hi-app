# Use a Node base image
FROM node:22-alpine3.19

# syntax=docker/dockerfile:1
   
FROM node:18-alpine
ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"
RUN corepack enable
COPY . /app
WORKDIR /app
RUN pnpm install
CMD ["pnpm", "run","start"]
EXPOSE 3000
