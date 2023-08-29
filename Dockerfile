FROM ubuntu:latest

RUN apt update
RUN apt install iputils-ping -y

ENTRYPOINT [ "ping" ]
CMD [ "google.com" ]