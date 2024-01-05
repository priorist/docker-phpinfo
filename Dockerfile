# Disclaimer: This Dockerfile is provided as-is without any warranty. This uses
#             PHP's built-in web server, it is indended for development
#             purposes only and is not suitable for production. Use at your own
#             risk.

# Latest base of Official Alpine 
FROM alpine:latest

# Taking responsibility
LABEL maintainer="Harry S <git@harrysy.red>"

# Removing responsibility
RUN echo "Disclaimer: This Dockerfile is provided as-is without any warranty. Use at your own risk."

# Installing PHP and cleaning up packet cache
RUN apk update && \
    apk add php && \
    rm -rf /var/cache/apk/*

# Alpine already using php.ini-production as ini file. Run command below to
# verify:
# grep -q "This is the php.ini-production INI" php.ini && echo "Prod"

# Copy content from src to 'html' folder 
COPY --chown=www-data:www-data src /html

# Adding less privilaged user
RUN adduser -D -H -u 1000 -G www-data www-data

# Changing to less privilaged user for more security
USER www-data

# Starting PHP built-in HTTP *development* server hosting files in the 'html'
# folder
CMD ["php", "-S", "0.0.0.0:80", "-t", "/html"]

# -S addr:port
#    Start built-in web server on the given local address and port.
#    Set to 0.0.0.0 to listen for external connections.
# -t document_root
#    Specify the document root to be used by the built-in web server.
# Note: The built-in web server is intended for development purposes and is not
# suitable for production.

# Exposes port 80 (http) to allow external connections on port 80 for tcp
# traffic
EXPOSE 80/tcp

