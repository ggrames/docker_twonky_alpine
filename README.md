-----------------------------------------------
## Version Info - packed components
-----------------------------------------------
# Twonky Server
Internet download 
* Server version: 8.3 (twonky-x86-64-glibc-2.9-8.3) 

----------------------------------
## User
----------------------------------
# User for running Server
In the Dockerfile the user twonky is created and used to run the twonky server instance

--------------------------------
## Build / Run the image
--------------------------------
docker build -t="twonky_alpine" .

# Run the image and mount local media directory to it
be careful concerning the permissions (Docker does not know the local user in the host)
docker run --name twonky -p 9000:9000 -v /usr/share/httpd/icons:/home/twonky/media -it twonky_alpine

--------------------------------
## Login to the container
--------------------------------
docker exec -it twonky /bin/bash

