<!-- FIXME: Rewrite to match current paths -->
## Building

From your checkout of the [Flapjack repository](https://github.com/flapjack/flapjack):

``` bash
git checkout gh-pages
bundle
bundle exec guard
```

Guard will monitor all files (bar `_site/`) and trigger a Jekyll build on change.

View your changes at [http://localhost:9000/](http://localhost:9000/).

To manually trigger a Jekyll rebuild:

```
rake build
```

This will copy slate documentation from `../slate/build` if it's available.

### JSONAPI documentation

JSONAPI documentation is in a [separate repository](https://github.com/flapjack/slate).

There is a task to pull a built copy of the documentation into the Jekyll site:

``` bash
rake slate
```

This will copy slate documentation from `../slate/build` if it's available.

Calling `rake build` will also call the `slate` task.


### LiveReload

If you are using the LiveReload browser extension, Guard will reload the site in your browser when you make changes.

To set this up:

 1. [Install the LiveReload browser extension](http://feedback.livereload.com/knowledgebase/articles/86242-how-do-i-install-and-use-the-browser-extensions-)
 2. Visit the development site at [http://localhost:9000/](http://localhost:9000/).
 3. Enable the LiveReload browser extension on development site tab
 4. Reload the tab
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


## Developing

To edit the JSONAPI documentation:

``` bash
git clone git@github.com:flapjack/slate.git
cd slate
bundle
bundle exec middleman server
```

You can now see the docs at [http://localhost:4567](http://localhost:4567).

## Building for [flapjack.io](http://flapjack.io/)

When you want to push updated documentation to [flapjack.io](http://flapjack.io/), run:

``` bash
rake build
```

The resulting documentation lives in the `build/` directory.

From the [gh-pages branch](https://github.com/flapjack/flapjack/tree/gh-pages) of your clone of [flapjack/flapjack](https://github.com/flapjack/flapjack), run:

``` bash
rake slate
```

And `git commit` the changes.

For more info on building documentation, check out the [upstream documentation](https://github.com/tripit/slate/wiki/Deploying-Slate) on building Slate documentation.
