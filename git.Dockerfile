FROM ubuntu:20.04
RUN apt-get update -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y curl iproute2 inetutils-tools telnet inetutils-ping git vim
RUN apt-get install --no-install-recommends --no-install-suggests ca-certificates -y