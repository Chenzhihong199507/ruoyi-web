# build front-end
FROM node:lts-alpine AS frontend

RUN npm install pnpm -g

WORKDIR /app

COPY ./package.json /app

COPY ./pnpm-lock.yaml /app

RUN pnpm install

COPY . /app

RUN pnpm build

FROM nginx:stable-alpine as production

COPY --from=frontend /app/dist /app/public

COPY ./nginx.conf /etc/nginx/nginx.conf

EXPOSE 6039

CMD ["pnpm", "run", "prod"]
