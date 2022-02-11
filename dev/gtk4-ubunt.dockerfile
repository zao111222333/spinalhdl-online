# docker build --network host -t zao111222333/gtk4-ubunt -f gtk4-ubunt.dockerfile .
# docker run --privileged --rm -it -p 5000:8085 zao111222333/gtk4-ubunt
FROM ubuntu:20.04

ENV LANG C.UTF-8
ENV TERM dumb
ENV VERBOSE true
ENV TZ America/Los_Angeles
# COPY src/sources.list-focal /etc/apt/sources.list
RUN rm -Rf /var/lib/apt/lists/* \
 && apt-get update -y && apt-get upgrade -y\
 && apt-get install -y --no-install-recommends \
    libgtk-4-dev gtk-4-examples geany
# gtk4-broadwayd :5&
# GDK_BACKEND=broadway BROADWAY_DISPLAY=:5 gtk4-query-settings

