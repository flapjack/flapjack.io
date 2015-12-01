## Developing

Clone the repository:

```
git clone https://github.com/flapjack/flapjack.git
```

Install development dependencies:

```
# Install Ruby dependencies
gem install bundler
bundle install
# Install Go dependencies and build binaries
./build.sh
```

You'll also need Redis installed:

```
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

```
bundle exec rspec spec
```

The following environment variables will change the behaviour of the rspec tests:

- `SHOW_LOGGER_ALL` - if set, will print out all logger messages
- `SHOW_LOGGER_ERRORS` - if set, will print out all logger messages at ERROR or FATAL level
- `COVERAGE` - enables SimpleCov for code coverage reporting, see below

Integration testing is done with Cucumber, and integration tests live in `features/`.

To run the integration tests, check out the code and run:

```
bundle exec cucumber features
```

If you have a failing scenario and would like to see the log leading up to the error, you can put in a line like the following above the failing line in the scenario:

```gherkin
  And show me the lovely log
```

You can use whatever adjective you like in there, so tune it to suit the mood of the moment.

API client integration tests are done with [pact](https://github.com/realestate-com-au/pact). To verify:

```
bundle exec rake pact:verify
```

Code Coverage Reporting
-----------------------

To engage [SimpleCov](https://github.com/colszowka/simplecov) for a code coverage report, set the COVERAGE environment variable before running one (or both) of the test suites:

```
COVERAGE=1 rake spec
COVERAGE=1 rake features
open coverage/index.html
```

Note that SimpleCov will merge the results of the two test suite's measured code coverage if you run them both within a 10 minute period.

Startup and Shutdown
--------------------
Copy the example configuration file into place:

```
if [ ! -e etc/flapjack_config.toml ] ; then
  cp etc/flapjack_config.toml.example etc/flapjack_config.toml
else
  echo "you've already got a config file at etc/flapjack_config.toml, exiting"
fi
```

Ensure your local Redis server is running, and then start it:

```
FLAPJACK_ENV=development bundle exec bin/flapjack --config etc/flapjack_config.toml server
```

When running, check you can access the web interface at [localhost:3080](http://localhost:3080/). The port can be modified in etc/flapjack_config.toml under `gateways` - `web` - `port`.

Releasing
---------

Gem releases are handled with [Bundler](http://gembundler.com/rubygems.html).

Before building the gem for release, you need to do a bit of housekeeping:

- Update the flapjack version string

```
vi lib/flapjack/version.rb
```

- Update the changelog - add the new version and list each issue it addresses. The [Releases](https://github.com/flapjack/flapjack/releases) github page will help you discover which commits have been pushed to master since the last release.

```
vi CHANGELOG.md
```

- Update the bundle (travis (among others) will get upset if you don't):

```shell
bundle
```

- Run the tests (to be sure, to be sure)

```
bundle exec rspec spec && \
bundle exec rake pact:verify && \
bundle exec cucumber features && \
(cd src/flapjack && go test -v)
```

- Fix the tests, or abort the release mission, if any tests are failing.
- Commit (use the actual new version string in the commit message and gem push below)

```
git commit -a -m 'prepare v0.0.0 release'
```

To build the gem, run:

```
bundle exec gem build flapjack.gemspec
```

To push the gem to rubygems.org run:

```
bundle exec gem push flapjack-0.0.0.gem
```

Once the gem has been released, you'll most likely be wanting to build and upload the [omnibus package](https://github.com/flapjack/omnibus-flapjack/) using the instructions [here](https://github.com/flapjack/omnibus-flapjack/blob/master/README.md)

You can then test the latest package with [vagrant-flapjack](https://github.com/flapjack/vagrant-flapjack):

```
git clone https://github.com/flapjack/vagrant-flapjack.git && cd vagrant-flapjack
flapjack_component=experimental distro_release=trusty vagrant up
```

RESTful API for input, output and actions
-----------------------------------------
See [API](../../jsonapi)

Internal Data Structures
---------------
See [Data Structures](../DATA_STRUCTURES)
