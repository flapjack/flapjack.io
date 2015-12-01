# Frequently Asked Questions (FAQ)

Below you'll find answers to some common questions that come up in #flapjack on `irc.freenode.net`, and conversations about Flapjack.

If you have questions you think need answering here, please [open a GitHub](https://github.com/flapjack/flapjack/issues/new) issue and we'll get it written up!


## What is the oldest version of Redis usable with Flapjack?

2.6.12 is the current minimum required version of Redis.

This is because Flapjack uses [SET's NX option](http://redis.io/commands/SET) for some queries. (NB: this may change before the full release of Flapjack v2, at which point 2.4.x would probably be the new effective minimum version.)

There are a couple of data functions that have simpler/faster code paths if the Redis version is greater than or equal to 2.8.0 / 2.8.19, but those have fallbacks to work on earlier Redis versions.


## Do I need to set up alerting in Nagios or Sensu for Flapjack to work?

No. Flapjack sends alerts independently of check execution engines like Nagios or Sensu.

There is nothing stopping you from sending alerts from both your upstream check execution engines and Flapjack, but you will receive duplicate alerts.

Flapjack sits downstream of check execution engines like Nagios and processes a stream of events emitted by them. Because Flapjack sees all events from the upstream check execution engines, it can do smart things like alert summarisation (rollup), de-duplication (in cases where you have multiple check executors monitoring the same thing), and alert routing.


## Why does Flapjack use event heartbeating to decide whether to send alerts?

Flapjack assumes a constant stream of events from upstream event producers, and this is fundamental to Flapjack's design.

![a beating heart](http://media.giphy.com/media/yeUxljCJjH1rW/giphy.gif)

Flapjack asks a fundamentally different question to other notification and alerting systems: "How long has a check been failing for?". Flapjack cares about the elapsed time, not the number of observed failures.

Alerting systems that depend on counting the number of observed failures to decide whether to send an alert suffer problems when the observation interval is variable.

Take this scenario with a LAMP stack running in a large cluster:

> 1. Nagios detects a single failure in the database layer. It increments the soft state by 1.
> 2. Nagios detects every service that depends on the database layer is now failing due to timeouts. It increments the soft state by 1 for each of these services.
> 3. The timeouts for each of these services cause the next recheck of the original database layer check to be delayed (e.g. after an additional 3 minutes). When it is eventually checked, its soft state is incremented.
> 4. The timeouts for the other services get bigger, causing the database layer check to be delayed further.
> 5. Eventually the original database layer check enters a hard state and alerts.

The above example is a little exaggerated, however the problem with using observed failure counts as a basis for alerting are obvious.

[Control theory](http://en.wikipedia.org/wiki/Control_theory) gives us a lot of practical tools for modelling scenarios like these, and the answer is never pretty - if you rely on the number of times you've observed a failure to determine if you need to send an alert, you're alerting effectiveness is limited by any latency in your checkers.

By looking at how long something has been failing for, Flapjack limits the effects of latency in the observation interval, and provides alerts to humans about problems faster.


## Why can't I send a one-off event to Flapjack?

Technically you can - Flapjack just won't notify anyone until:

 - Two events (or more) have been received by Flapjack.
 - 30 seconds have elapsed between the first event received by Flapjack and the latest.

This is due to the aforementioned heartbeating behaviour that is baked into Flapjack's design.

As more people are using Flapjack we are seeing increasing demand for one-off event submission. There are two key cases:

 - Arbitrary event submission via HTTP
 - Routing CloudWatch alarms via Flapjack

One attempt at solving this is the [HTTP broker](./Http-Broker) that Flapjack packages now ship with.


## How do I scale Flapjack?

With ease!

When people talk about monitoring scalability, they tend to be talking about one of two things: performance or scalability.

### Performance

The first performance bottleneck you will hit with Flapjack is the event processing speed of the processor. As you increase the number of events that you feed Flapjack, the processor eventually won't be able to handle the number of events.

You can observe this very clearly by watching your event queue length increasing and not returning to previous levels quickly:

<p class="text-center">
  <img class="img-responsive" src="http://i.imgur.com/mf9XYt3.gif" alt="event queue length visualisation"/>
</p>

While there will almost always be performance improvements we can make within Flapjack, a big part of the performance story comes down to the lack of multicore support in C-based Ruby implementations. Flapjack currently uses Ruby 1.9 - 2.2, and will also work on recent versions of JRuby.

You can work around this by adding more Flapjack processors and/or notifiers. These can either run on a single host, or across multiple hosts.

Here's an example configuration file for a standalone processor:

```toml
# flapjack-processor-1.toml
[logger]
  file = "log/flapjack.log"
  level = "INFO"
  syslog_errors = true
[redis]
  host = "127.0.0.1"
  port = 6380
  db = 0
[processor]
  enabled = false
  queue = "events"
  notifier_queue = "notifications"
  initial_failure_delay = 30
  repeat_failure_delay = 60
  initial_recovery_delay = 0
  archive_events = false
[notifier]
  enabled = false
```

You should have a separate config file per-Flapjack processor (so logs don't conflict).

<div class="bs-callout bs-callout-info">
  <h4>Rule of thumb</h4>
  <p>Number of processors on a machine should equal the number of cores available, minus the number of Redis instances:
<pre>
number of Flapjack processors count == number of cores - number of redis instances
</pre>
</p>
</div>

To test out the limits of Flapjack's event processing speed in your environment, you can use the `flapjack simulate fail` tool to create lots of events quickly:

```
flapjack simulate fail -i 0.001 -k "foo-app-01:http" --time 60 -c etc/flapjack_config.toml
```

Scaling the web + API gateways is just like scaling any web app - just throw up more instances and sit them behind a reverse proxy.

### High Availability

As mentioned in the Performance section above, you can run multiple instances of the Flapjack components (processor, notifier, gateways).

We recommend you also do this for HA.

The processor and notifier will easily run in separate instances across multiple machines, provided they can all talk to the same Redis instance.

Flapjack makes this easy by allowing you to specify what components you want to run within the Flapjack config. You can run all the components on a single machine, one component per host, or a mix.


## I remember Flapjack from a few years ago. Is this the same project?

Not quite - it's the same project in spirit, but from a technical perspective it is quite different.

When Flapjack was originally written in 2009 it was focused on being a replacement for Nagios. Once a working prototype of Flapjack was built, it quickly become obvious that the notification and alerting part of Nagios was actually a far trickier problem to solve than anticipated, and [Flapjack's author](http://fractio.nl) had bitten off too much to chew.

The Flapjack project languished, and other tools like Sensu came along and built solid, scalable check execution infrastructure far better than anything in the original Flapjack.

Flapjack was rebooted in 2012 to focus exclusively on the alert routing and notification problem. Flapjack's core developers have been sponsored to work on Flapjack close to full-time.

All of the code is completely new, and the only commonality between the two code bases is the name.



