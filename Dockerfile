########################################################################
#		Run the Consul server and webui
########################################################################
FROM            ubuntu:14.04
MAINTAINER      chris.mague@shokunin.co

#
RUN apt-get update && apt-get install -y unzip

# Install the consul binary and web ui

ADD https://dl.bintray.com/mitchellh/consul/0.4.1_linux_amd64.zip /tmp/consul.zip
RUN cd /bin && unzip /tmp/consul.zip && chmod +x /bin/consul

ADD https://dl.bintray.com/mitchellh/consul/0.4.1_web_ui.zip /tmp/webui.zip
RUN cd /tmp && unzip /tmp/webui.zip && mv dist /ui && rm /tmp/webui.zip

# Add consul configs
ADD ./config /config/
ONBUILD ADD ./config /config/

# runscript that takes arguments!
ADD ./scripts/run-consul-server /bin/run-consul-server
RUN chmod +x /bin/run-consul-server

#Create a mount point
VOLUME ["/data"]

# Expose consul ports
EXPOSE 8300 8301 8301/udp 8302 8302/udp 8400 8500 53/udp

ENTRYPOINT ["/bin/run-consul-server"]
