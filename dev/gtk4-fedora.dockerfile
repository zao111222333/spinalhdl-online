# docker build --network host -t zao111222333/gtk4-fedora -f gtk4-fedora.dockerfile .
# docker run --privileged --rm -it -p 5000:5000 zao111222333/gtk4-fedora
FROM fedora:34

ENV LANG C.UTF-8
ENV TERM dumb
ENV VERBOSE true
ENV TZ America/Los_Angeles

RUN dnf -y upgrade
RUN dnf -y groupinstall "Development Tools"
RUN dnf -y install gtk4-devel
gtk4-broadwayd :5&
GDK_BACKEND=broadway BROADWAY_DISPLAY=:5 gtk4-query-settings