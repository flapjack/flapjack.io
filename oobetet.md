The "Out Of Band, End To End Test" (oobetet) is a self-check mechanism within Flapjack that verifies the stream of events from the upstream event producers is current. 

The oobetet verifies this currency of the event stream by watching for a state change on a specific check within a period of time. 

If the oobetet does not observe a state change, it fires an alert. 

This helps you identify when your upstream event producers have gotten stuck, e.g. Nagios has hung, the node has gone away, etc.

## How it works

The oobetet works like this:

![oobetet high level](artwork/oobetet-high-level.png)

Let's start at the bottom of the diagram. 

The oobetet watches for a specific check on a specific entity. If it detects that check doesn't change state within a period of (we recommend 5 minutes), it will fire an alert. 

Here is an example oobetet config from the Flapjack configuration file:


``` 
oobetet:
  enabled: yes
  server: "jabber.example.com"
  port: 5222
  jabberid: "flapjacktest@jabber.example.com"
  password: "nuther-good-password"
  alias: "flapjacktest"
  watched_check: "Flapper"
  watched_entity: "flapper-on-nagios-01.example.org"
  max_latency: 300
  pagerduty_contact: "11111111111111111111111111111111"
  rooms:
    - "flapjacktest@conference.jabber.example.com"
    - "gimp@conference.jabber.example.com"
    - "log@conference.jabber.example.com"
  logger:
    level: INFO
    syslog_errors: yes
```

The key configuration sections are: 

 - `watched_check` - what check should oobetet should watch for the state change.
 - `watched_entity` - what entity that check should be associated with. 
 - `max_latency` - the maximum amount of time allowed to pass between state changes on that check. 
  
  
### Event producers

The upstream monitoring check is expected to switch between states within that time period. If it does not an alert will fire. 

Assuming you're running Nagios as your check execution engine, and your Nagios is hooked up to Flapjack with `flapjack-nagios-receiver`, here's an example Nagios config to setup a flapping service:

```
define host {
  use            base
  host_name      flapper-on-nagios-01.example.org
  alias          flapper-on-nagios-01
  address        192.168.100.10
}

define service {
  use                 base
  host_name           flapper-on-nagios-01.example.org
  service_description Flapper
  check_command       check_tcp!12345
  check_interval      10
  retry_interval      10
}

define command {
  command_name check_tcp
  command_line $USER1$/check_tcp -H $HOSTADDRESS$ -p $ARG1$
}
```

Flapjack ships a Flapper service that the above `check_tcp` check queries. The Flapper service oscillates between opening and closing TCP port 12345, at a user-specified frequency (the default is 120 seconds). 

You start it like this:

```
flapper start
```

## Stringing it all together

With the above configuration:

 - Nagios checks the Flapper service is available every 10 seconds
 - Nagios reports the events to Flapjack via the `flapjack-nagios-receiver`
 - Flapjack passes the state change notifications to the oobetet
 - The oobetet checks the notifications are coming through at least every 5 minutes
 - If the oobetet detects the state changes aren't happening, it sends a notification

