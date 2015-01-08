# Installation

## Distribution packages (Ubuntu, Debian, Centos)

The recommended platform to run Flapjack on (other than development) is one of the following:
- Ubuntu Precise 64 (Ubuntu 12.04)
- Ubuntu Trusty (Ubuntu 14.04)
- Debian Wheezy (Debian 7)
- Centos 6

We provide packages for these platforms on our [package repository](http://packages.flapjack.io).
The packages include all runtime dependencies, so you shouldn't need to install anything else to get flapjack up and running with a vanilla configuration.

If you just want to have a quick play with Flapjack, use [vagrant-flapjack](https://github.com/flapjack/vagrant-flapjack), as this will also take care of creating and setting up a virtual machine using one of the above platforms, and installing flapjack for you.

To install the package on one of the platforms above, add the Flapjack repository to your sources, and install the flapjack package:

### Debian and Ubuntu:

Add the Flapjack package signing key:

```bash
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 8406B0E3803709B6
```

Add the Flapjack package repository corresponding to your distro and release (pick one of the following to run):

```bash
# Ubuntu Precise
echo 'deb http://packages.flapjack.io/deb/v1 precise main' | sudo tee  /etc/apt/sources.list.d/flapjack.list

# Ubuntu Trusty
echo 'deb http://packages.flapjack.io/deb/v1 trusty main' | sudo tee  /etc/apt/sources.list.d/flapjack.list

# Debian Wheezy
echo 'deb http://packages.flapjack.io/deb/v1 wheezy main' | sudo tee  /etc/apt/sources.list.d/flapjack.list
```

Go forth and install:

```bash
sudo apt-get update
sudo apt-get install flapjack
```

### Centos

Copy and paste the following lines in one go to add the Flapjack package repository to your yum repository list:

```
cat >/etc/yum.repos.d/flapjack.repo << EOL
[flapjack-v1]
name=Flapjack v1
baseurl=http://packages.flapjack.io/rpm/v1/flapjack/centos/6/x86_64/
enabled=1
EOL
```

Install the package:

```bash
yum install --nogpgcheck flapjack
```

Nb: You'll need to start up redis-flapjack and then flapjack on CentOS, instructions forthcoming. TODO

More details are available at [packages.flapjack.io](http://packages.flapjack.io/)

You should now find that flapjack and redis have started up. Try visiting the [flapjack web interface](http://localhost:3080).

## Installing as a gem

If you're determined to run Flapjack on an unsupported platform, you can install the Flapjack ruby gem as follows:

Install build-essential, and Ruby 2.1.1 using [rbenv](https://github.com/sstephenson/rbenv), and then run:

``` bash
gem install flapjack
```

# Configuration

The default configuration file is located at /etc/flapjack/flapjack_config.yaml.

# Running

Flapjack is made of a number of components, all accessible via the Flapjack executable.

Information on each command can be accessed by running `flapjack command help`

``` text
    flapper  - Artificial service that oscillates up and down, for use in http://flapjack.io/docs/1.0/usage/oobetet
    import   - Bulk import data from an external source, reading from JSON formatted data files
    receiver - Receive events from external systems and sends them to Flapjack
    server   - Server for running components (e.g. processor, notifier, gateways)
    simulate - Simulates a check by creating a stream of events for Flapjack to process
```
