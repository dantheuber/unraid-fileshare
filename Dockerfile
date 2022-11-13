FROM node:16 as dev-deps
WORKDIR /modules
COPY package*.json ./
RUN npm i --development

FROM node:16 as build
WORKDIR /app
COPY --from=dev-deps /modules ./
COPY tsconfig.json ./
COPY src/ ./src
RUN ./node_modules/.bin/tsc

FROM node:16 as prod-deps
WORKDIR /modules
COPY package*.json ./
RUN npm i --production

FROM node:16
WORKDIR /server
COPY --from=build /app/dist /server/
COPY --from=prod-deps /modules /server/
COPY dist ./
EXPOSE 3123
CMD ["node", "."]