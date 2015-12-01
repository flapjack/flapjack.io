# Configuring the SMS_Twilio gateway

[Twilio](https://www.twilio.com/) is a provider of SMS and voice communications with a rich API. This gateway only makes use of one way SMS sending. It should work to most countries in the world, and has been tested with US and Australian mobile numbers.

## Config Options

## notifier

| Config | Synopsis | Description |
|--------|----------|-------------|
| sms_twilio_queue | String | The name of the queue to use for sending messages to the sms_twilio gateway |

## gateways/sms_twilio

| Config | Synopsis | Description |
|--------|----------|-------------|
| enabled | yes/no  | Enable this gateway? |
| queue   | String  | The queue name to listen on. Must match the 'sms_twilio_queue' defined in the notitifier. |
| account_sid | String | The Account SID of your Twilio account |
| auth_token  | String | The authentication token for your Twilio Account |
| from    | String  | The number to send SMS messages from. You must have this number configured in your Twilio account. |
| logger/level | FATAL/ERROR/WARN/INFO/DEBUG | The logging verbosity of the gateway. Set to DEBUG, reload flapjack, and consult flapjack.log if you're having trouble. |
| logger/syslog_errors | yes/no | Send logging messages at ERROR or FATAL to the syslog |
| templates/alert.text | String | Path to a custom template for alerts about individual checks. Must ben an ERB file. See the [default](https://github.com/flapjack/flapjack/blob/master/lib/flapjack/gateways/sms_twilio/alert.text.erb)|
| templates/rollup.text | String | Path to a custom template for rollup alerts. Must be an ERB file. See the [default](https://github.com/flapjack/flapjack/blob/master/lib/flapjack/gateways/sms_twilio/rollup.text.erb). |


