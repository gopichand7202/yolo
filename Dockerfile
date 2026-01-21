FROM nginx:alpine




# Run Nginx in foreground
CMD ["nginx", "-g", "daemon off;"]

