#consul-master

Build a consul cluster on docker and run with terraform

##prerequisites

1. Install and configure [docker](http://docs.docker.com/linux/started/)
2. Install terraform from [Hashicorp](https://terraform.io/)


##building

Building the consul docker image is done using the following command

```
sudo docker build -t maguec/consul-master .
```

##running

```
# destroy the directory and re-create - stale data will cause 500 errors
sudo rm -rf /data/docker/consul1
sudo mkdir -p /data/docker/consul1

cd terraform

# view what would happen
sudo terraform plan

# apply the configuration
sudo terraform apply

# due to the spinup time you may have to run apply twice
```

##using
To connect to the consul web-ui

http://localhost:8500/ui/
