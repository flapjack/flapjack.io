## Http Check Engine

Flapjack ships with a simple http check engine. This can check the availability of websites and services.
Failures and successes are reported to Flapjack as heartbeats - just like any other check.

With this, you can start using Flapjack straight away.  

### Setting up a http check

The http checker runs as a Flapjack subcommand:

```
flapjack receiver httpchecker -c ~/http-checker-config.json
```

This will load the specified config file and run as many checks as it has been told to.
Each check will result in a stream of heartbeat events to Flapjack - OK or CRITICAL
depending on the check result.

### Configuration

This is a sample http-checker-config.json file:

```
{

  "monitors": [
    {
      "type": "http-status",
      "url": "http://localhost:8000",
      "name": "My website healthcheck",
      "freq": "10s",
      "timeout": "2s"
    },
    {
      "type": "http-status",
      "url": "http://awesome-web:9090/health",
      "name": "Some important service",
      "freq": "30s",
      "timeout": "10s"
    }

  ],

  "notifiers": [
    {
      "type": "flapjack",
      "address" : "FLAPJACK_HOST:6380"
    },
    {
      "type": "stderr"
    }
  ]
}
```

#### Monitors

Monitors are the HTTP URLs to check - the name will appear as part of the
entity and check information in Flapjack (as will the URL).

You can have as many monitors as you like - set a suitable poll time and timeout.
Don't worry about the odd false positive - as this is heartbeat based Flapjack will
smooth out the bumps.

#### Notifiers

Enture that the "flapjack" type is pointing to the Flapjack redis instance and that it
is accessible. The stderr just ensures that error are printed to stderr as well.


### How it works

The httpchecker pushes events into the Flapjack embedded redis server.
This is based on the project called [pandik](https://github.com/oguzbilgic/pandik).
