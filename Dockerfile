FROM node:16.13.2-alpine as build-env
ENV APP_HOME /sveltekit-template
WORKDIR $APP_HOME
COPY . $APP_HOME/
RUN npm ci
RUN npm run build

FROM node:16.13.2-alpine
WORKDIR /sveltekit-template
COPY --from=build-env /sveltekit-template/ /sveltekit-template/
RUN apk --no-cache --upgrade add curl
RUN apk --no-cache add bash
ENV PORT=8080
CMD [ "node", "build" ]
