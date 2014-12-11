# Configuring the Web gateway

The Flapjack web interface runs out of the web gateway. Here's how you configure it.

## Config Options

## gateways/web

| Config | Synopsis | Description |
|--------|----------|-------------|
| enabled | yes/no  | Enable this gateway? |
| port    | Integer  | The TCP port to listen on |
| timeout | Integer  | Read timeout in Seconds |
| auto_refresh | Integer  | Seconds between auto_refresh of entities/checks pages.  Set to 0 to disable |
| access_log | String  | Path to the access log (log of all http requests) |
| base_url | String | URL your Flapjack web UI is available at, used for generating internal links eg `http://flapjack.example/` Default: `/` |
| api_url | String | Url the javascript in the Web UI will use to access the API (JSONAPI) |
| logo_image_path | String | Full path to the location of an alternate logo file, e.g. /etc/flapjack/custom_logo.png |
| show_exceptions | yes/no | Show exceptions (sinatra style) Default: no |
| logger/level | FATAL/ERROR/WARN/INFO/DEBUG | The logging verbosity of the gateway. Set to DEBUG, reload flapjack, and consult flapjack.log if you're having trouble. |
| logger/syslog_errors | yes/no | Send logging messages at ERROR or FATAL to the syslog |

## edit contacts interface

Most of the web interface is pretty plain HTML, and read only save for some forms. The /edit_contacts interface departs from this and uses backbone.js and jquery to acces the JSONAPI in order to make changes to contacts.

For this to work for your users, you need to set the api_url of the web gateway to be a URL for the JSONAPI that is accessable from your user's browsers. The example config file has a 127.0.0.1 (localhost) URL in here, which will only work if you're browsing to the Flapjack web interface from the same computer that's running Flapjack. You will want to change this to point to a fqdn of your Flapjack server, eg `http://flapjack-api.example:3081/`

