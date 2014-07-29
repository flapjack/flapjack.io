# Configuring Nagios

You need a Nagios prior to version 3.3 as it introduced [a bug that breaks perfdata output](http://tracker.nagios.org/view.php?id=247) for checks which don't generate performance data (text after a | in the check output).

Because this output is omitted, `flapjack receiver nagios` is unable to parse event information from Nagios and send it to Flapjack.

There are unconfirmed reports Nagios releases in the 3.4.x series have a fix for the perfdata, however we have not confirmed this. Nagios 4.x *may* also work, however this is also unconfirmed.

We are developing and running against Nagios version 3.2.3 with success.

`nagios.cfg` config file changes:

```text
# modified lines:
enable_notifications=0
host_perfdata_file=/var/cache/nagios3/event_stream.fifo
service_perfdata_file=/var/cache/nagios3/event_stream.fifo
host_perfdata_file_template=[HOSTPERFDATA]\t$TIMET$\t$HOSTNAME$\tHOST\t$HOSTSTATE$\t$HOSTEXECUTIONTIME$\t$HOSTLATENCY$\t$HOSTOUTPUT$\t$HOSTPERFDATA$
service_perfdata_file_template=[SERVICEPERFDATA]\t$TIMET$\t$HOSTNAME$\t$SERVICEDESC$\t$SERVICESTATE$\t$SERVICEEXECUTIONTIME$\t$SERVICELATENCY$\t$SERVICEOUTPUT$\t$SERVICEPERFDATA$
host_perfdata_file_mode=p
service_perfdata_file_mode=p
```

What we're doing here is telling Nagios to generate a line of output for every host and service check into a named pipe. The template lines must be as above so that `flapjack receiver nagios` knows what to expect.

All hosts and services (or templates that they use) will need to have process_perf_data enabled on them. (This is a real misnomer, it doesn't mean the performance data will be processed, just that it will be fed to the perfdata output channel, a named pipe in our case.)

Create the named pipe if it doesn't already exist:

    mkfifo -m 0666 /var/cache/nagios3/event_stream.fifo

Note that the templates used in the nagios configuration for service_perfdata_file_template and host_perfdata_file_template must be configured to be exactly as flapjack-nagios-receiver expects otherwise it will drop events that don't match the expected format. The current requirements for the data format that flapjack-nagios-receiver expects from the named pipe is as per the above nagios templates. The following checks are made of each line of textual data found in the pipe, and if any fail the line does not result in an event being created:

The line must:
- split into at least 9 tab-separated words
- contain a unix timestamp in the 2nd word (seconds since epoch) - so just a whole number
- the first word (object type) must contain either `[HOSTPERFDATA]` or `[SERVICEPERFDATA]`.

Currently any error messages about lines that are unable to be read are written to STDOUT.

## Limitations with the flapjack receiver nagios approach

We have seen loss of events with this event transport when the number of events being generated between dumps to the named pipe goes above some threshold. It would appear as though Nagios is overflowing an internal buffer for the performance data between each 10 or 20 second perfdata output flush. This was of the order of thousands of events per flush. It could also have been some other aspect of this transport causing events to be lost.

For this reason, a nagios event broker module - [flapjackfeeder](https://github.com/flapjack/flapjackfeeder) - is being developed to offer an alternative to flapjack receiver nagios for high check throughput environments, or potentially a full replacement.
