FROM node:16 as dev-deps
WORKDIR /modules
COPY package*.json ./
RUN npm i

FROM node:16 as build
WORKDIR /app
COPY --from=dev-deps /modules ./
COPY src/ ./src
RUN /app/node_modules/.bin/typescript

FROM node:16 as prod-deps
WORKDIR /modules
COPY package*.json ./
RUN npm i --production

FROM node:16
WORKDIR /server
COPY --from=build /app/dist /server/
COPY --from=prod-deps /modules /server/
COPY dist ./
CMD ["node", "."]