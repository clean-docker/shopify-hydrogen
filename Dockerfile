FROM node:16 AS build-env

WORKDIR /app
RUN yarn create hydrogen-app tmp -s
RUN mv tmp/* . && rm -rf tmp
RUN yarn
RUN yarn build

FROM gcr.io/distroless/nodejs:16 AS run-env
ENV NODE_ENV production
COPY --from=build-env /app /app

EXPOSE 8080

WORKDIR /app
CMD ["server.js"]
