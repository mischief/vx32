FROM debian:jessie
MAINTAINER Nick Owens <mischief@offblast.org>
RUN dpkg --add-architecture i386
RUN apt-get update
RUN apt-get install -y build-essential
RUN apt-get install -y libc6-i386 libc6-dev-i386 libx11-dev:i386 libx11-xcb-dev:i386 libxau-dev:i386 libxdmcp-dev:i386

