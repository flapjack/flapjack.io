Developing Flapjack
-------------------

Clone the repository:

```bash
git clone https://github.com/flapjack/flapjack.git
```

Install development dependencies:

```bash
# Install Ruby dependencies
gem install bundler
bundle install
# Install Go dependencies and build binaries
./build.sh
```

You'll also need Redis installed:

```bash
# Mac OS X with Homebrew:

brew update
brew install redis

# ... and follow the instructions on adding redis as a launch agent (launchctl load etc)

# Debian based Linux:

apt-get update
apt-get install redis
```

Flapjack is, and will continue to be, well tested. Monitoring is like continuous
integration for production apps, so why shouldn't your monitoring system have tests?

Unit testing is done with RSpec, and unit tests live in `spec/`.

To run the unit tests, check out the code and run:

```bash
rake spec
```

The following environment variables will change the behaviour of the rspec tests:

- `SHOW_LOGGER_ALL` - if set, will print out all logger messages
- `SHOW_LOGGER_ERRORS` - if set, will print out all logger messages at ERROR or FATAL level
- `COVERAGE` - enables SimpleCov for code coverage reporting, see below

Integration testing is done with Cucumber, and integration tests live in `features/`.

To run the integration tests, check out the code and run:

```bash
rake features
```

NB, if the cucumber tests fail with a [spurious lexing error](https://github.com/cucumber/gherkin/issues/182) then try this:

```bash
cucumber -f fuubar features
```

If you have a failing scenario and would like to see the log leading up to the error, you can put in a line like the following above the failing line in the scenario:

```gherkin
  And show me the lovely log
```

You can use whatever adjective you like in there, so tune it to suit the mood of the moment.

Code Coverage Reporting
-----------------------

To engage [SimpleCov](https://github.com/colszowka/simplecov) for a code coverage report, set the COVERAGE environment variable before running one (or both) of the test suites:

```bash
COVERAGE=x rake spec
COVERAGE=x rake features
open coverage/index.html
```

Note that SimpleCov will merge the results of the two test suite's measured code coverage if you run them both within a 10 minute timeout.

Startup and Shutdown
--------------------
Copy the example configuration file into place:

```bash
if [ ! -e etc/flapjack_config.yaml ] ; then
  cp etc/flapjack_config.yaml.example etc/flapjack_config.yaml
else
  echo "you've already got a config file at etc/flapjack_config.yaml, exiting"
fi
```

Ensure your local Redis server is running, and then to start:

```bash
FLAPJACK_ENV=development bundle exec bin/flapjack --config etc/flapjack_config.yaml server start
```
Stop:

```bash
FLAPJACK_ENV=development bundle exec bin/flapjack --config etc/flapjack_config.yaml
```

Get the status:

```bash
FLAPJACK_ENV=development  bundle exec bin/flapjack --config etc/flapjack_config.yaml server status
```

Flapjack can also be started in the foreground (non-daemonized) by adding `--no-daemonize` to the start command, eg:

```bash
FLAPJACK_ENV=development bundle exec bin/flapjack --config etc/flapjack_config.yaml server start --no-daemonize
```

When running, check you can access the web interface at [localhost:3080](http://localhost:3080/). The port for development can be modified in etc/flapjack_config.yaml under `development` - `gateways` - `web` - `port`.

Releasing
---------

Gem releases are handled with [Bundler](http://gembundler.com/rubygems.html).

Before building the gem for release, you need to do a bit of housekeeping:

- Update the flapjack version string
  `vi lib/flapjack/version.rb`
- Update the changelog - add the new version and list each issue it addresses. The [Releases](https://github.com/flapjack/flapjack/releases) github page will help you discover which commits have been pushed to master since the last release.
  `vi CHANGELOG.md`
- Update the bundle
  `bundle`
- Run the tests (to be sure, to be sure)
  `bundle exec rake spec && bundle exec rake features`
- Fix the tests, or abort the release mission, if any tests are failing.
- Commit (use the actual new version string in the commit message below)
  `git commit -a -m 'prepare v0.0.0 release'`

To build the gem, run:

```bash
bundle exec rake build
```

To push the gem to rubygems.org run:

```bash
bundle exec rake release
```

Once the gem has been released, you'll most likely be wanting to build the [omnibus package](https://github.com/flapjack/omnibus-flapjack/):

```
git clone https://github.com/flapjack/omnibus-flapjack.git && cd omnibus-flapjack
vagrant up ubuntu-precise64
```

... and [push it up](https://github.com/flapjack/omnibus-flapjack/#updating-the-debian-package-repo-ubuntu-precise-only-at-present) to [packages.flapjack.io](http://packages.flapjack.io).

You can then test the latest package with [vagrant-flapjack](https://github.com/flapjack/vagrant-flapjack):
```bash
git clone https://github.com/flapjack/vagrant-flapjack.git && cd vagrant-flapjack
vagrant up
```

Data Structures
---------------
See [Data Structures](../DATA_STRUCTURES)

RESTful API for input, output and actions
-----------------------------------------
See [API](../../jsonapi)

Importing via the command line
------------------------------
See [Importing](../../usage/IMPORTING)

Architecture
------------

FIXME document check data format, for writing new check receivers
