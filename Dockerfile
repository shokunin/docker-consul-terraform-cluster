########################################################################
#		Run the Consul server and webui
########################################################################
FROM            ubuntu:14.04
MAINTAINER      chris.mague@shokunin.co

#
RUN apt-get update && apt-get install -y unzip

# Install the consul binary and web ui

ADD https://releases.hashicorp.com/consul/0.6.4/consul_0.6.4_linux_amd64.zip /tmp/consul.zip
RUN cd /bin && unzip /tmp/consul.zip && chmod +x /bin/consul

ADD https://releases.hashicorp.com/consul/0.6.4/consul_0.6.4_web_ui.zip /tmp/webui.zip
RUN mkdir -p /ui && cd /tmp && unzip /tmp/webui.zip && rm /tmp/webui.zip && mv *.html /ui && mv static /ui

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
