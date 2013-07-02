## How is Flapjack currently distributed?

* As a [gem on rubygems.org](https://rubygems.org/gems/flapjack)
* We have a Rake task to [build the gem](https://github.com/flpjck/flapjack/wiki/DEVELOPING#releasing)
* There is a single gem for [flapjack](https://rubygems.org/gems/flapjack)
* There is a single gem for [flapjack-diner](https://rubygems.org/gems/flapjack-diner)

## How does a user currently install Flapjack?

* Users install Redis
* Users install the gem, then they need to mess with the config file
* We are currently managing the config files with Puppet under /etc/flapjack
* We create a log directory under /var/log/flapjack

## How does Flapjack run?

* Internally, Flapjack functionality is contained in pikelets (term coined by [@ali-graham](http://github.com/ali-graham)\)
* We can run many pikelets in a single process
* In the future we may fire up separate EventMachine loops
* Right now there is a single EM loop
* The config file controls which pikelets are booted
* The config file controls the logging levels

## Are we happy with how Flapjack is packaged and distributed?

* We have problems when we want to easily deploy a branch to a development/QA environment
* There are two targets: development releases, and public releases
* [Opscode](http://opscode.com) have written a way to package up large dependency trees
* They've called this [Omnibus](https://github.com/opscode/omnibus)
* It statically compiles Ruby, and pulls in all the dependencies under a single directory

### Problems we have right now:

* The install instructions aren't that great
* We don't provide info on where the configs should be placed
* We don't ship a default config (are there sensible defaults?)
* Should we create an example config file on boot, if none is supplied?

### Are RubyGems a good distribution mechanism?

* When the project gets large enough, we should consider splitting the gem up
* One issue with Omnibus is that it only produces RPMs and debs
* This only lowers the barrier of entry for Linux users, not everyone else
* This isn't necessarily a bad thing, as long as we make it possible to install Flapjack via RubyGems
* A lot of early adopters are running Arch Linux, so we should target that platform

### Are there alternative ways of releasing Flapjack?

* [logstash](http://logstash.net) takes a different approach
  * logstash bundles up all the gems + a copy of JRuby into a single jar
  * Anyone that has a JVM can then run the jar
  * This would allow Flapjack to be run easily on Windows, Linux, OS X

## What do we want Flapjack releases to look like?

1. We want to create a great user experience for people running Flapjack the first time
  * People should be able to run Flapjack without any config
  * This would populate some default contacts, "standard reference data"
1. Build Flapjack [packages with Omnibus](https://github.com/flpjck/omnibus-flapjack) for Debian, RedHat, Arch 
  * Omnibus lowers the barrier of entry, because users don't need to worry about all the dependencies
1. Publish packages in a public repository
  * Do we use a Launchpad PPA?
  * Or run our own package repository infrastructure at packages.flapjack.io?
1. Update install documentation to reference package repos
1. Release a Vagrant box that install packages via Puppet
  * This will act as a reference implementation for integrating Flapjack into your monitoring stack