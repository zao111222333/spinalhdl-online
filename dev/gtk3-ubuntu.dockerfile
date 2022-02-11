# docker build --network host -t zao111222333/gtk3-ubuntu -f gtk3-ubuntu.dockerfile .
# docker run --rm -it -p 5000:8085 zao111222333/gtk3-ubuntu
FROM ubuntu:16.04

# ENV LANG C.UTF-8
# ENV TERM dumb
# ENV VERBOSE true
# ENV TZ America/Los_Angeles
COPY src/sources.list-bionic /etc/apt/sources.list
RUN rm -Rf /var/lib/apt/lists/* \
 && apt-get update -y && apt-get upgrade -y\
 && apt-get install -y --no-install-recommends \
    libgtk-3-bin gtk-3-examples
# broadwayd :5&
# GDK_BACKEND=broadway BROADWAY_DISPLAY=:5 gtk3-demo

