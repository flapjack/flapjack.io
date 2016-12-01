---

# Quickstart

This quickstart guide will get you [Flapjack](http://flapjack.io/) running in a VM locally using Vagrant and VirtualBox.

You'll also learn the basics of how to:

- Configure Flapjack
- Simulate a failure of a monitored service
- Integrate Flapjack with Nagios (or Icinga), so Flapjack takes over alerting

To skip this tutorial and jump straight to the code, view the project on [GitHub](https://github.com/flapjack/flapjack).

## Getting Flapjack running

### Dependencies

- [Vagrant](http://vagrantup.com/) 1.5+
- [VirtualBox](https://www.virtualbox.org/wiki/Downloads) 4.3+
  (or an alternative provider such as [VMware Fusion](http://www.vmware.com/au/products/fusion/)
  and the [Vagrant plugin](http://www.vagrantup.com/vmware)

### Setup

Get the repo, and build your Vagrant box, using your preferred distro_release.  Supported distro releases are 'precise', 'trusty', 'wheezy', and 'centos-6'.

```bash
git clone https://github.com/flapjack/vagrant-flapjack.git
cd vagrant-flapjack
distro_release=trusty vagrant up
```

For an alternative provider to VirtualBox (e.g. VMware Fusion), you can specify the provider when running `vagrant up`:

```bash
distro_release=trusty vagrant up --provider=vmware_fusion
```

<div class="alert alert-info">
<strong>More information:</strong>
Check out the <a class="alert-link" href="https://github.com/flapjack/vagrant-flapjack">vagrant-flapjack</a> project on GitHub.
</div>

## Using Flapjack

Flapjack will now be visible at [http://localhost:3080](http://localhost:3080) from your host workstation.
You should see the Flapjack Web UI:

![Screenshot of the Flapjack Web UI](/images/2.0/quickstart/web-ui.png)

To continue with this guide, SSH into the vagrant box:

``` bash
vagrant ssh
```

You'll find the commands under `/opt/flapjack/bin` and in `PATH`:

```bash
flapjack help
flapjack simulate help
```

### The checks

Flapjack can receive check execution results from a number of different systems.  When it does, Flapjack creates the check, and its entity, and starts retaining history of state changes etc.

For now, we'll create our own  using Flapjack's simulate command:

```bash
flapjack simulate fail \
  --check "restaurant1:bacon" \
  --interval 1 \
  --time 0.1

flapjack simulate ok \
  --check "restaurant1:eggs" \
  --interval 1 \
  --time 0.1

flapjack simulate fail_and_recover \
  --check "restaurant2:pancakes" \
  --interval 1 \
  --time 0.1
```

The definition of these commands are as follows:

```text
flapjack simulate fail             - Generate a stream of failure events
flapjack simulate fail_and_recover - Generate a stream of failure events, and one final recovery
flapjack simulate ok               - Generate a stream of ok events
```

You can now see these under the [list of checks](http://localhost:3080/checks).

![Screenshot of the list of checks](/images/2.0/quickstart/check-list.png)

#### Maintenance (including acknowledgements)

There are two types of maintenance - scheduled and unscheduled maintenance. An acknowledgment creates an unscheduled maintenance starting at the time of the acknowledgement.

All checks are created with a period of scheduled maintenance, 100 years by default. This can be altered, or disabled, in the flapjack config file.

Click the 'End Now' button on the [bacon check](http://localhost:3080/checks?name=restaurant1%3Abacon) to end this maintenance.

#### Unscheduled maintenance (acknowledgements)

Our `restaurant1:bacon` check is now critical, and sending out alerts.  To acknowledge this check, and silence the alerts, we add unscheduled maintenance for a period of time by filling out the [Acknowledge Alert](http://localhost:3080/checks?name=restaurant1%3Abacon) box.

![Screenshot of adding unscheduled maintenance](/images/2.0/quickstart/add-unscheduled-maintenance.png)

#### Scheduled maintenance

If you want to add scheduled maintenance (lets say we know bacon will be off the menu next Saturday), fill out the 'Add Scheduled Maintenance' box further down the page.

#### Maintenance CLI

You can also add, list and remove maintenance by using the CLI tool `flapjack maintenance`:

```bash
flapjack maintenance show   - Show maintenance windows according to criteria (default: all ongoing maintenance)
flapjack maintenance delete - Delete maintenance windows according to criteria (default: all ongoing maintenance)
flapjack maintenance create - Create a maintenance window
```

### The people

[Contacts](../jsonapi/#contacts) and [media](../jsonapi/#media) can be added through the API.

The bottom of the [check page](http://localhost:3080/checks?name=restaurant1%3Abacon) lists which contacts will be notified of events.

### The outputs

To enable gateways, edit /etc/flapjack/flapjack_config.yaml and update the enabled flag for the given gateways:

```toml
[gateways]
  # Generates email notifications
  [gateways.email]
    enabled = true
```

Further configuration options are available in each of the gateway blocks.

### Getting real data into Flapjack

Both Nagios and Icinga are configured already to send data to Flapjack's broker module, which sends it to redis, in place of the earlier Flapjack Nagios receiver.

![Flapjack's architecture](/images/2.0/quickstart/architecture.png)

More details on configuration are available [here](./Configuring-Nagios).

### Feedback?

Found an error in the above? Please [submit a bug report](https://github.com/flapjack/flapjack/issues/new) and/or a pull request against the [flapjack.io repository](https://github.com/flapjack/flapjack.io) with the fix.

Something not clear? That's a bug too!

Got questions? Suggestions? Talk to us via irc, mailing list, or twitter. See [Support](/support) for details.

### Coming soon

Stay tuned for more info on how to configure:

- notification rules
- intervals
- summary thresholds

In the mean time, check out:

 - [JSONAPI documentation](../jsonapi) for working with individual contacts and entities
 - [flapjack-diner](https://github.com/flapjack/flapjack-diner), the ruby client interface to Flapjack's API
