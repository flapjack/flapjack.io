# Omnibus in your Docker

This doc covers how to get a local development environment going for building Flapjack packages.

## Set up a docker server

The easiest way to do this is to use [Docker Machine](https://docs.docker.com/machine/) to manage a VirtualBox VM running [boot2docker linux](https://github.com/boot2docker/boot2docker), a very lightweight linux distro designed to run docker server and not much else (it uses busybox for your shell if you ssh into it). The boot2docker cli is written in Go and runs on Mac OS, Windows and Linux.

You may need to specify some configuration, in particular so the IP range is within a subnet that your VPN is not going to grab routes to:

**~/.boot2docker/profile**

```
DiskSize = 20000
Memory = 2048
SSHPort = 2022
DockerPort = 2375
HostIP = "172.20.10.3"
DHCPIP = "172.20.10.99"
NetMask = [255, 255, 255, 0]
LowerIP = "172.20.10.103"
UpperIP = "172.20.10.254"
DHCPEnabled = true
```

Create, and start up, your docker server:

```
docker-machine start default
eval "$(docker-machine env default)"
```

Test that everything is working:

```
docker ps
```

You should see:

```
$ docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
```

This shows that there are no docker containers running.

## Download omnibus-ubuntu / omnibus-debian / omnibus-centos images

Pull down the latest flapjack/omnibus-distro images from the docker registry for your preferred distribution:

```
docker pull flapjack/omnibus-ubuntu
docker pull flapjack/omnibus-debian
docker pull flapjack/omnibus-centos
```

This will pull down several images each. If you just want an image for a particular Ubuntu release, supply either the `trusty` or `precise` tags to the above `docker pull` command, eg:

```
docker pull flapjack/omnibus-ubuntu:trusty
```

The same applies to Debian and Centos:

```
docker pull flapjack/omnibus-debian:wheezy
docker pull flapjack/omnibus-centos:6
```

Details of the build history and so on for omnibus-ubuntu are visible on the [Docker Hub](https://registry.hub.docker.com/u/flapjack/omnibus-ubuntu).

The image is rebuilt automatically when the [omnibus-ubuntu repo](https://github.com/flapjack/omnibus-ubuntu) receives new commits.

## Build

Now you should be good to [build packages](https://github.com/flapjack/omnibus-flapjack/blob/master/README.md#build) with the [omnibus-flapjack](https://github.com/flapjack/omnibus-flapjack/blob/master/README.md#build) project.
