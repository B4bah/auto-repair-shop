FROM nginx:alpine

# Copy the custom nginx config from the project root's nginx folder
COPY nginx/nginx.conf /etc/nginx/nginx.conf

# Copy your static files (HTML, CSS, JS, IMG) into nginx's web root
FROM nginx:alpine
COPY nginx/nginx.conf /etc/nginx/nginx.conf
COPY frontend /usr/share/nginx/html/
RUN rm -rf /usr/share/nginx/html/nginx

EXPOSE 80
