# Configuring the Web gateway

The Flapjack web interface runs out of the web gateway. Here's how you configure it.

## Config Options

## gateways/web

| Config | Synopsis | Description |
|--------|----------|-------------|
| enabled | yes/no  | Enable this gateway? |
| port    | Integer  | The TCP port to listen on |
| timeout | Integer  | Read timeout in seconds |
| auto_refresh | Integer  | Seconds between auto_refresh of checks pages.  Set to 0 to disable |
| access_log | String  | Path to the access log (log of all http requests) |
| base_url | String | URL your Flapjack web UI is available at, used for generating internal links eg `http://flapjack.example/` Default: `/` |
| api_url | String | URL the javascript in the Web UI will use to access the API (JSONAPI) |
| logo_image_path | String | Full path to the location of an alternate logo file, e.g. /etc/flapjack/custom_logo.png |
| show_exceptions | yes/no | Show exceptions (sinatra style) Default: no |
| logger/level | FATAL/ERROR/WARN/INFO/DEBUG | The logging verbosity of the gateway. Set to DEBUG, reload flapjack, and consult flapjack.log if you're having trouble. |
| logger/syslog_errors | yes/no | Send logging messages at ERROR or FATAL to the syslog |
