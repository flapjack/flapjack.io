## Building

From your checkout of the [Flapjack.io repository](https://github.com/flapjack/flapjack.io):

``` bash
bundle exec middleman build
bundle exec middleman server
```

Middleman will monitor all files in source/ and trigger a build on change.

View your changes at [http://localhost:4567/](http://localhost:4567/).

# Flapjack JSONAPI documentation


The Flapjack JSONAPI lets you work with Flapjack data, including:

- Contacts
- Media
- PagerDuty credentials
- Notification Rules
- Entities
- Checks
- Reports


The [flapjack-diner](http://github.com/flapjack/flapjack-diner) RubyGem provides a Ruby client library for Flapjack's JSONAPI.

The Flapjack JSONAPI documentation is built using [Slate](https://github.com/tripit/slate).

## Building for [flapjack.io](http://flapjack.io/)

When you want to push updated documentation to [flapjack.io](http://flapjack.io/), run:

``` bash
rake build
```

The resulting documentation lives in the `build/` directory.

