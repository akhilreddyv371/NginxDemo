# Use official Nginx image
FROM nginx:latest

# Remove default index.html
RUN rm -rf /usr/share/nginx/html/*

# Copy custom HTML files
COPY html /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
