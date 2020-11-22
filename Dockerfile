# Stage 0, "build-stage", based on Node.js, to build and compile the frontend
FROM node:10.8.0 as build-stage
WORKDIR /app
COPY package*.json /app/
RUN npm install
COPY ./ /app/
ARG configuration=production
RUN npm run build -- --output-path=./dist/fruits-frontend

# Stage 1, based on Nginx, to have only the compiled app, ready for production with Nginx
FROM nginx:1.15
#ENV PORT=4200
#ENV BACKEND_SERVICE=""
#Copy default nginx configuration
COPY ./nginx.conf /etc/nginx/conf.d/default.conf
#Copy ci-dashboard-dist
COPY --from=build-stage /app/dist/fruits-frontend /usr/share/nginx/html
