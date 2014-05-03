# Flapjack JSONAPI documentation


The Flapjack JSONAPI lets you work with Flapjack data, including: 

- Contacts
- Media
- PagerDuty credentials
- Notification Rules
- Entities
- Checks
- Reports


The [flapjack-diner](http://github.com/flpjck/flapjack-diner) RubyGem provides a Ruby client library for Flapjack's JSONAPI. 

The Flapjack JSONAPI documentation is built using [Slate](https://github.com/tripit/slate).


## Developing

To edit the JSONAPI documentation:

``` bash
git clone git@github.com:flpjck/slate.git
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

From the [gh-pages branch](https://github.com/flpjck/flapjack/tree/gh-pages) of your clone of [flpjck/flapjack](https://github.com/flpjck/flapjack), run: 

``` bash
rake slate
```

And `git commit` the changes. 

For more info on building documentation, check out the [upstream documentation](https://github.com/tripit/slate/wiki/Deploying-Slate) on building Slate documentation. 