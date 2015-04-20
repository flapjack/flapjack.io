## Http Broker

Flapjack ships with an HTTP event broker that accepts events from external check execution systems over HTTP. The events are a json blob as defined in the Data Structure documentation with the addition of a 'ttl' attribute (time to live, in seconds).

The http broker can be used for non-heartbeat style event streams, where you send along a TTL and the broker will then cache the last state and repeatedly emit events for this check until the TTL expires, whereupon it’ll start generating UNKNOWN events for that check.

The HTTP Broker is available as the `httpbroker` subcommand of the `receiver` subcommand eg `flapjack receiver httpbroker`.

Output of `flapjack receiver httpbroker --help`

```text
usage: httpbroker [<flags>]

Flags:
  --help               Show help.
  --port="3090"        Address to bind HTTP server (default 3090)
  --server="localhost:6380"
                       Redis server to connect to (default localhost:6380)
  --database=DATABASE  Redis database to connect to (default 0)
  --interval=10s       How often to submit events (default 10s)
  --debug              Enable verbose output (default false)
  --version            Show application version.
```

### Example

Start up the http broker on the default listen port of 3090 with debug verbosity:

```bash
flapjack1dev receiver httpbroker --debug
```


Submit an event:

```bash
curl -w 'response: %{http_code} \n' -X POST \
  -H "Content-type: application/json" -d \
  '{
    "entity": "foo-app-01",
    "check": "PING",
    "type": "service",
    "tags": "apps",
    "state": "OK",
    "summary": "3 ms round trip"
    "ttl": 30
  }' http://localhost:3090/state
```

You should get something like the following back from the curl command:

```text
Caching state: {"entity":"foo-app-01","check":"PING","type":"service",
"state":"OK","summary":"3 ms round trip","time":1429505587,"ttl":30}
response: 200
```

You should see some output from http broker like this:

```
2015/04/20 14:29:56 Booting with config: {Port::3090 Server:localhost:6380 Database:0 Interval:10s Debug:true}
2015/04/20 14:29:56 Number of cached states: 0
[martini] Started POST /state for 127.0.0.1:51911
2015/04/20 14:29:58 Caching state: {"entity":"foo-app-01","check":"PING","type":"service","state":"OK","summary":"","time":1429505998,"ttl":30}
[martini] Completed 200 OK in 330.572us
2015/04/20 14:30:06 Number of cached states: 1
2015/04/20 14:30:06 Sending event data for foo-app-01:PING
2015/04/20 14:30:16 Number of cached states: 1
2015/04/20 14:30:16 Sending event data for foo-app-01:PING
2015/04/20 14:30:26 Number of cached states: 1
2015/04/20 14:30:26 Sending event data for foo-app-01:PING
2015/04/20 14:30:36 Number of cached states: 1
2015/04/20 14:30:36 State for foo-app-01:PING is stale. Sending UNKNOWN.
2015/04/20 14:30:36 Sending event data for foo-app-01:PING
2015/04/20 14:30:46 Number of cached states: 1
2015/04/20 14:30:46 State for foo-app-01:PING is stale. Sending UNKNOWN.
2015/04/20 14:30:46 Sending event data for foo-app-01:PING
```

Notice how after the 30 second TTL expires the http broker starts sending UNKNOWN for this check.

### Limitations

* No state is persisted between restarts. http broker will start with a clean slate each time it starts up.
