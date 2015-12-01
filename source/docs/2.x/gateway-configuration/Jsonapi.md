# Configuring the JSONAPI gateway

The Flapjack JSONAPI gateway provides an HTTP API adhering fairly as closely as possible the [JSONAPI](http://jsonapi.org) v1.0 specification, and also to the Swagger 1.2 documentation format.

## Config Options

## gateways/jsonapi

| Config | Synopsis | Description |
|--------|----------|-------------|
| enabled | yes/no  | Enable this gateway? |
| port    | Integer  | The TCP port to listen on |
| timeout | Integer  | Read timeout in seconds |
| access_log | String  | Path to the access log (log of all http requests) |
| base_url | String | The main URL of this service, eg `http://flapjack-api.example/` |
| logger/level | FATAL/ERROR/WARN/INFO/DEBUG | The logging verbosity of the gateway. Set to DEBUG, reload flapjack, and consult flapjack.log if you're having trouble. |
| logger/syslog_errors | yes/no | Send logging messages at ERROR or FATAL to the syslog |

