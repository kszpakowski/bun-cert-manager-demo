FROM node:20.16.0-slim AS builder
WORKDIR /home/node/app

COPY package.json package-lock.json ./
RUN npm ci

COPY tsconfig.json ./
COPY src src
RUN npm run build

FROM gcr.io/distroless/nodejs20-debian12
WORKDIR /home/node/app

COPY --from=builder /home/node/app/package.json ./
COPY --from=builder /home/node/app/node_modules node_modules
COPY --from=builder /home/node/app/dist ./

# USER node
EXPOSE 9443/tcp
CMD ["index.js"]
# ENTRYPOINT [ "node", "index.js" ]