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
rspec spec
```

Integration testing is done with Cucumber, and integration tests live in `features/`.

To run the integration tests, check out the code and run:

```bash
cucumber features
```

NB, if the cucumber tests fail with a [spurious lexing error](https://github.com/cucumber/gherkin/issues/182) on line 2 of events.feature, then try this:

```bash
cucumber -f fuubar features
```


Releasing
---------

Gem releases are handled with [Bundler](http://gembundler.com/rubygems.html).

To build the gem, run:

```bash
gem build flapjack.gemspec
```



Architecture
------------

TODO -- more detailed than in USING.md

FIXME document check data format, for writing new check receivers
