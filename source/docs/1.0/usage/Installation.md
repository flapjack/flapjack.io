# Installation

## Debian packages

The recommended platform to run Flapjack on (other than development) is Ubuntu Precise 64 (Ubuntu 12.04, amd64).
We provide a package for this platform on our [package repository](http://packages.flapjack.io).
The package includes all runtime dependencies, so you shouldn't need to install anything else to get flapjack up and running with a vanilla configuration.

If you just want to have a quick play with Flapjack, use [vagrant-flapjack](https://github.com/flapjack/vagrant-flapjack), as this will also take care of creating and setting up an Ubuntu virtual machine and installing flapjack for you.

To install the package on Ubuntu Precise 64, add the Flapjack repository to your apt sources, and install the flapjack package:

```
deb http://packages.flapjack.io/deb precise main
```

eg:

```bash
echo 'deb http://packages.flapjack.io/deb precise main' | sudo tee  /etc/apt/sources.list.d/flapjack.list
sudo apt-get update
sudo apt-get install flapjack
```

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
