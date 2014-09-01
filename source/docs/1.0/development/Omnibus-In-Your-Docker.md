# Omnibus in your Docker

This doc covers how to get a local development environment going for building Flapjack packages.

## Set up a docker server

The easiest way to do this is to use [boot2docker-cli](https://github.com/boot2docker/boot2docker-cli) to manage a VirtualBox VM running [boot2docker linux](https://github.com/boot2docker/boot2docker), a very lightweight linux distro designed to run docker server and not much else (it uses busybox for your shell if you ssh into it). The boot2docker cli is written in Go and runs on Mac OS, Windows and Linux.

Here's how I installed it on Mac OS X Mavericks (10.9.3) with homebrew and VirtualBox 4.3.10 already installed:

```
brew update
brew install boot2docker
```

Specify some configuration, in particular so the IP range is within a subnet that your VPN is not going to grab routes to:

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

Create, and start up, your boot2docker docker server:

```
boot2docker init
boot2docker start
```

It'll give you an address to set DOCKER_HOST to so that your docker cli knows how to access your docker server, so you'll then need to run something the following:

```
export DOCKER_HOST=tcp://172.20.10.103:2375
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

More better [doco on boot2docker](https://github.com/boot2docker/boot2docker) is available.

## Download omnibus-ubuntu images

Pull down the latest flapjack/omnibus-ubuntu images from the docker registry:

```
docker pull flapjack/omnibus-ubuntu
```

This will pull down several images. If you just want an image for a particular Ubuntu release, supply either the `trusty` or `precise` tags to the above `docker pull` command, eg:

```
docker pull flapjack/omnibus-ubuntu:trusty
```

Details of the build history and so on for omnibus-ubuntu are visible on the [Docker Hub](https://registry.hub.docker.com/u/flapjack/omnibus-ubuntu).

The image is rebuilt automatically when the [omnibus-ubuntu repo](https://github.com/flapjack/omnibus-ubuntu) receives new commits.

## Build

Now you should be good to [build packages](https://github.com/flapjack/omnibus-flapjack/blob/master/README.md#build) with the [omnibus-flapjack](https://github.com/flapjack/omnibus-flapjack/blob/master/README.md#build) project.


