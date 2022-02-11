# docker build --network host -t spinalhdl-online .
# docker push spinalhdl-online
# docker run -itd \
#   --restart=always \
#   -p 8848:8080 \
#   -e USER=username \
#   -e PASS=123456 \
#   -e WORKDIR=/SpinalHDL/ \
#   -v /path/in/host/:/SpinalHDL/ \
#   spinalhdl-online:sbt
FROM zao111222333/spinalhdl-online:mill