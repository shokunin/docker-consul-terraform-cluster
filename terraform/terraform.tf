######################################################################################
#               Start up the master with ports and volumes
######################################################################################
resource "docker_container" "consul-master" {
  name    = "consul1"
  name    = "consul1"
  image   = "maguec/consul-master"
  command = [ "-server",
              "-bootstrap",
              "-dc=docker",
              "-node=consul1"]
  ports {
    internal = 8300
    external = 8300
  }
  ports {
    internal = 8301
    external = 8301
  }
  ports {
    internal = 8301
    external = 8301
    protocol = "udp"
  }
  ports {
    internal = 8302
    external = 8302
    protocol = "udp"
  }
  ports {
    internal = 8400
    external = 8400
  }
  ports {
    internal = 8500
    external = 8500
  }
  ports {
    internal = 53
    external = 8600
    protocol = "udp"
  }
  volumes {
    container_path = "/data"
    host_path      = "/data/docker/consul1"
  }
}
######################################################################################
resource "docker_container" "consul2" {
  name    = "consul2"
  name    = "consul2"
  image   = "maguec/consul-master"
  command = [ "-server",
              "-join=${docker_container.consul-master.ip_address}",
              "-node=consul2",
              "-dc=docker"]
}
######################################################################################
resource "docker_container" "consul3" {
  name    = "consul3"
  name    = "consul3"
  image   = "maguec/consul-master"
  command = [ "-server",
              "-join=${docker_container.consul-master.ip_address}",
              "-node=consul3",
              "-dc=docker"]
}
######################################################################################
# Set an example kye in the key/value store
provider "consul" {
  address    = "${docker_container.consul-master.ip_address}:8500"
  datacenter = "docker"
  scheme     = "http"
}
resource "consul_keys" "example_key" {
  datacenter = "docker"
  key {
    name  = "ludicrous-setting"
    path  = "settings/global/speed/ludicrous"
    value = "on"
  }
}
