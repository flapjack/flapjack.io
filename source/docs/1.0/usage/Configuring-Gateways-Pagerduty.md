# Configuring the Pagerduty gateway

[Pagerduty](https://www.pagerduey.com/) is a provider of alert delivery via SMS, phone calls, and push notifications. They also provide escalation and oncall rotation scheduling. Flapjack's Pagerduty gateway is bidirectional, in that it:

- sends alerts to pagerduty
- receives acknowledgements from pagerduty

Currently Flapjack polls Pagerduty for acknowledgements. A webhook listener may be added to the Flapjack Pagerduty gateway in the future.

The Flapjack Pagerduty gateway does not support rollup, given Pagerduty itself supports rollup.

## Config Options

## notifier

| Config | Synopsis | Description |
|--------|----------|-------------|
| pagerduty_queue | String | The name of the queue to use for sending messages to the pagerduty gateway |

## gateways/pagerduty

| Config | Synopsis | Description |
|--------|----------|-------------|
| enabled | yes/no  | Enable this gateway? |
| queue   | String  | The queue name to listen on. Must match the 'sms_twilio_queue' defined in the notitifier. |
| logger/level | FATAL/ERROR/WARN/INFO/DEBUG | The logging verbosity of the gateway. Set to DEBUG, reload flapjack, and consult flapjack.log if you're having trouble. |
| logger/syslog_errors | yes/no | Send logging messages at ERROR or FATAL to the syslog |
| templates/alert.text | String | Path to a custom template for alerts about individual checks. Must be an ERB file. See the [default](https://github.com/flapjack/flapjack/blob/master/lib/flapjack/gateways/pagerduty/alert.text.erb)|

## Contact Media Setup

Typically you'll only need one contact in Flapjack that has a Pagerduty contact medium configured. However you can have multiple, if you have several organisations in Pagerduty you wish to create incidents for.

The pagerduty contact medium takes several parameters as follows:

| Name | Description |
|------|-------------|
| service_key (string) | the API key for PagerDuty's integration API, corresponds to a 'service' within this contact's PagerDuty account |
| subdomain (string) | the subdomain for this contact's PagerDuty account, eg "foobar" in the case of https://foobar.pagerduty.com/ |
| username (string) | the username for the PagerDuty REST API (basic http auth) for reading data back out of PagerDuty |
| password (string) | the password for the PagerDuty REST API |


Currently the web interface does not support management of pagerduty credentials, it will only display them. Therefore, you need to use the api to do this. See the [jsonapi reference](http://flapjack.io/docs/1.0/jsonapi/#pagerduty-credentials) for details.


