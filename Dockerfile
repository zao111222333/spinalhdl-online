# docker build --network host -t zao111222333/spinalhdl-online:latest .
# docker push zao111222333/spinalhdl-online:latest
# docker run -itd \
#   --restart=always \
#   -p 8848:8080 \
#   -e USER=username \
#   -e PASS=123456 \
#   -e WORKDIR=/SpinalHDL/ \
#   -v /path/in/host/:/SpinalHDL/ \
#   spinalhdl-online:sbt
FROM zao111222333/spinalhdl-online:sbt-full