FROM nginx:stable-alpine

WORKDIR /usr/share/nginx/html

# Remove default nginx static assets and copy site files
RUN rm -rf ./*
COPY . .

# Serve on port 8080 for Google Cloud Run
RUN rm /etc/nginx/conf.d/default.conf
RUN printf 'server {\n  listen 8080;\n  listen [::]:8080;\n  server_name _;\n  root /usr/share/nginx/html;\n  index index.html index.htm;\n  location / {\n    try_files $uri $uri/ =404;\n  }\n}\n' > /etc/nginx/conf.d/default.conf

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]
