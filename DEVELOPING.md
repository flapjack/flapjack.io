Developing Flapjack
-------------------

Clone the repository:

```bash
git clone https://github.com/flpjck/flapjack.git
```

Install development dependencies:

```bash
gem install bundler
bundle install
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
Ensure your local redis server is running, and then to start:
```bash
bin/flapjack start
```
stop:
```bash
bin/flapjack stop
```
status:
```bash
bin/flapjack status
```
See [Using](USING) for more information.

Releasing
---------

Gem releases are handled with [Bundler](http://gembundler.com/rubygems.html).

To build the gem, run:

```bash
rake build
```

To push the gem to rubygems.org run:

```bash
rake release
```

Data Structures
---------------
See [Data Structures](DATA_STRUCTURES)

RESTful API for input, output and actions
-----------------------------------------
See [API](API)

Importing via the command line
------------------------------
See [Importing](IMPORTING)

Architecture
------------

TODO -- more detailed than in USING.md

FIXME document check data format, for writing new check receivers
