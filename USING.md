
## Installation


Install the Flapjack gem:

    sudo gem install flapjack


## Dependencies


Apart from a bundle of gems (see flapjack.gemspec for runtime gems, and Gemfile for additional gems required for testing):
- Ruby >= 1.9
- Redis >= 2.4.15


## What components do

Executables:

  * `flapjack` => starts multiple components ('pikelets') within the one ruby process as specified in the configuration file.
  * `flapjack-nagios-receiver` => reads nagios check output on standard input and places them on the events queue in redis as JSON blobs. Currently unable to be run in-process with `flapjack`

There are more executables in the bin directory (TODO describe them here).

Pikelets:

  * `executive` => processes events off a queue (a redis list) and decides what actions to take (alert, record state changes, etc)
  * `email_notifier` => generates email notifications (resque, mail)
  * `sms_notifier` => generates sms notifications (resque)
  * `jabber_gateway` => connects to an XMPP (jabber) server, sends notifications (to rooms and individuals), handles acknowledgements from jabber users and other commands (blather)
  * `pagerduty_gateway` => sends notifications to and accepts acknowledgements from [PagerDuty](http://www.pagerduty.com/) (NB: you will need to have a registered PagerDuty account to use this)
  * `oobetet` => "out-of-band" end-to-end testing, used for monitoring other instances of flapjack to ensure that they are running correctly
  * `web` => browsable web interface (sinatra, thin)
  * `api` => HTTP API server (sinatra, thin)

Pikelets are flapjack components which can be run within the same ruby process, or as separate processes.

The simplest configuration will have one `flapjack` process running executive, web, and some notification gateways, and one `flapjack-nagios-receiver` process receiving events from Nagios and placing them on the events queue for processing by executive.



## Architecture

TODO -- high-level overview, diagram, some notes



## Configuring Flapjack components

Copy the example config file into place:

```
cp etc/flapjack-config.yaml.example etc/flapjack-config.yaml
```

and then edit the configuration to suit. The value of the environment variable `FLAPJACK_ENV` is used as the configuration key, to choose which of the top-level configuration hashes in the YAML file should be loaded. (The default FLAPJACK_ENV is "development" if there is no environment variable set.)

An example configuration stanza is replicated below, along with comments describing the function of the configuration settings.

```yaml
development:
  pid_file: tmp/pids/flapjack.pid
  log_file: log/flapjack.log
  # whether or not flapjack should run daemonized (using the daemons gem)
  daemonize: no
  redis:
    # the redis server hostname to connect to
    host: 127.0.0.1
    # the redis server port to connect to
    port: 6379
    # the redis database number to use
    db: 13
  executive:
    # whether or not this pikelet should be started
    enabled: yes
    email_queue: email_notifications
    sms_queue: sms_notifications
    jabber_queue: jabber_notifications
    notification_log_file: log/flapjack-notification.log
  email_notifier:
    # whether or not this pikelet should be started
    enabled: yes
    # the redis queue the pikelet will look for notifications on
    queue: email_notifications
    smtp_config:
      # these values are passed directly through to the mail gem's SMTP configuration,
      # and can be omitted if the defaults are acceptable
      port: 25
      address: "localhost"
      domain: 'localhost.localdomain'
      user_name: nil
      password: nil
      authentication: nil
      enable_starttls_auto: true
  sms_notifier:
    # whether or not this pikelet should be started
    enabled: yes
    # the redis queue the pikelet will look for notifications on
    queue: sms_notifications
    username: "ermahgerd"
    password: "xxxx"
  jabber_gateway:
    # whether or not this pikelet should be started
    enabled: yes
    # the redis queue the pikelet will look for notifications on
    queue: jabber_notifications
    # the jabber server hostname to connect to
    server: "jabber.domain.tld"
    # the jabber server port to connect to
    port: 5222
    # the jabber username to present for signing in
    jabberid: "flapjack@jabber.domain.tld"
    # the jabber password to present for signing in
    password: "good-password"
    # the user alias the pikelet should use
    alias: "flapjack"
    # the Multi-User Chats the pikelet should join and announce to
    rooms:
      - "flapjacktest@conference.jabber.domain.tld"
      - "log@conference.jabber.domain.tld"
  oobetet:
    # whether or not this pikelet should be started
    enabled: yes
    # server, port, jabberid, password, alias, rooms: see the jabber pikelet
    server: "jabber.domain.tld"
    port: 5222
    jabberid: "flapjacktest@jabber.domain.tld"
    password: "nuther-good-password"
    alias: "flapjacktest"
    watched_check: "PING"
    watched_entity: "foo.bar.net"
    max_latency: 300
    pagerduty_contact: "11111111111111111111111111111111"
    rooms:
      - "flapjacktest@conference.jabber.domain.tld"
      - "log@conference.jabber.domain.tld"
  pagerduty_gateway:
    # whether or not this pikelet should be started
    enabled: yes
    # the redis queue the pikelet will look for notifications on
    queue: pagerduty_notifications
  web:
    # whether or not this pikelet should be started
    enabled: yes
    # the port the web server should be run on
    port: 5080
  api:
    # whether or not this pikelet should be started
    enabled: yes
    # the port the API server should be run on
    port: 5081
```


### Configuring Nagios

You need a Nagios prior to version 3.3 as this breaks perfdata output for checks which don't generate performance data (stuff after a | in the check output). We are developing and running against Nagios version 3.2.3 with success.

nagios.cfg config file changes:

```
# modified lines:
enable_notifications=0
host_perfdata_file=/var/cache/nagios3/event_stream.fifo
service_perfdata_file=/var/cache/nagios3/event_stream.fifo
host_perfdata_file_template=[HOSTPERFDATA]\t$TIMET$\t$HOSTNAME$\tHOST\t$HOSTSTATE$\t$HOSTEXECUTIONTIME$\t$HOSTLATENCY$\t$HOSTOUTPUT$\t$HOSTPERFDATA$
service_perfdata_file_template=[SERVICEPERFDATA]\t$TIMET$\t$HOSTNAME$\t$SERVICEDESC$\t$SERVICESTATE$\t$SERVICEEXECUTIONTIME$\t$SERVICELATENCY$\t$SERVICEOUTPUT$\t$SERVICEPERFDATA$
host_perfdata_file_mode=p
service_perfdata_file_mode=p
```

What we're doing here is telling Nagios to generate a line of output for every host and service check into a named pipe. The template lines must be as above so that `flapjack-nagios-receiver` knows what to expect.

All hosts and services (or templates that they use) will need to have process_perf_data enabled on them. (This is a real misnomer, it doesn't mean the performance data will be processed, just that it will be fed to the perfdata output channel, a named pipe in our case.)

Create the named pipe if it doesn't already exist:

    mkfifo -m 0666 /var/cache/nagios3/event_stream.fifo


## Running Flapjack


    bin/flapjack [options]

    $ flapjack --help
    Usage: flapjack [options]
        -c, --config [PATH]              PATH to the config file to use
        -d, --[no-]daemonize             Daemonize?

The command line option for daemonize overrides whatever is set in the config file.


### flapjack-nagios-receiver

There is a control script that uses [Daemons](http://daemons.rubyforge.org/) to start, stop, restart, show status etc of the flapjack-nagios-receiver process. Options after -- are passed through to flapjack-nagios-receiver. Run it like so:

    flapjack-nagios-receiver-control start -- --config /etc/flapjack/flapjack-config.yaml --fifo /path/to/nagios/perfdata.fifo
    flapjack-nagios-receiver-control status
    flapjack-nagios-receiver-control restart -- --config /etc/flapjack/flapjack-config.yaml --fifo /path/to/nagios/perfdata.fifo
    flapjack-nagios-receiver-control stop

#### Bypassing daemons control script

Specify the path to the nagios named pipe (fifo):

    flapjack-nagios-receiver --fifo /var/cache/nagios3/event_stream.fifo

Now as nagios feeds check execution results into the perfdata named pipe, flapjack-nagios-receiver will convert them to JSON encoded ruby objects and insert them into the *events* queue.



### executive

Flapjack executive processes events from the 'events' list in redis. It does a blocking read on redis so new events are picked off the events list and processed as soon as they created.

When executive decides somebody ought to be notified (for a problem, recovery, or acknowledgement or what-have-you) it looks up contact information and then creates a notification job on one of the notification queues (eg sms_notifications) in rescue, or via the jabber_notifications redis list which is processed by the jabber_gateway.


### Resque Workers

We're using [Resque](https://github.com/defunkt/resque) to queue email and sms notifications generated by flapjack-executive. The queues are named as follows:
- email_notifications
- sms_notifications

There'll be more of these as we add more notification mediums.

Note that using the flapjack-config.yaml file you can have flapjack start the resque workers in-process. Or you can run them standalone with the `rake resque:work` command as follows.

One resque worker that processes both queues (but prioritises SMS above email) can be started as follows:

    QUEUE=sms_notifications,email_notifications VERBOSE=1 be rake resque:work

resque sets the command name so grep'ing ps output for `rake` or `ruby` will NOT find resque processes. Search instead for `resque`. (and remember the 'q').

To background it you can add `BACKGROUND=yes`. Excellent documentation is available in [Resque's README](https://github.com/defunkt/resque/blob/master/README.markdown)


### Redis Database Instances

We use the following redis database numbers by convention:

* 0 => production
* 13 => development
* 14 => testing



## Importing contacts and entities (CLI)

The `flapjack-populator` script provides a mechanism for importing contacts and entities from JSON formatted import files.

    bin/flapjack-populator import-contacts --from tmp/dummy_contacts.json --config /etc/flapjack/flapjack-config.yml
    bin/flapjack-populator import-entities --from tmp/dummy_entities.json --config /etc/flapjack/flapjack-config.yml

There are example files, and example ruby code which generated them, in the tmp/ directory. The format of these files is described herein:


### Format of JSON contact + entity data

The `flapjack-populator` script populates the event processing/notification database with entities and contacts. This initialises the entities for which checks will be monitored, which contacts are interested in which entities, and the notification details for these contacts (email address, mobile number for SMS, etc.).

The import process will delete any existing matching object (matching on ID) before importing the new details, so if an object is being updated, the whole object must be exported. In this way we can handle the removal of an email address in the media hash for example. The operation on Redis is wrapped in a transaction, so the update is atomic.

The two JSON files are specified as follows:


### Contacts

The contacts json import data is an array of contacts as follows:

```
CONTACTS  (array) = [CONTACT, CONTACT, ...]
CONTACT   (hash)  = { "id": CONTACT_ID, "first_name": FIRST_NAME, "last_name": LAST_NAME, "email": EMAIL, "media": MEDIA }
MEDIA     (hash)  = { MEDIA_TYPE: MEDIA_ADDRESS, MEDIA_TYPE: MEDIA_ADDRESS, "pagerduty": PAGERDUTY... }
PAGERDUTY (hash)  = { "service_key": PAGERDUTY_SERVICE_KEY, "subdomain": PAGERDUTY_SUBDOMAIN, "username": PAGERDUTY_USERNAME, "password": PAGERDUTY_PASSWORD }

CONTACT_ID            (string) - a unique, immutable identifier for this contact
MEDIA_TYPE            (string) - one of "email", "sms", "jabber", or any other media type we add support for in the future
MEDIA_ADDRESS         (string) - address to send to for the paired MEDIA_TYPE, eg an email address, mobile phone number, or jabber id
PAGERDUTY_SERVICE_KEY (string) - the API key for PagerDuty's integration API, corresponds to a 'service' within this contact's PagerDuty account
PAGERDUTY_SUBDOMAIN   (string) - the subdomain for this contact's PagerDuty account, eg "companyname" in the case of https://companyname.pagerduty.com/
PAGERDUTY_USERNAME    (string) - the username for the PagerDuty REST API (basic http auth) for reading data back out of PagerDuty
PAGERDUTY_PASSWORD    (string) - the password for the PagerDuty REST API
```

* The MEDIA hash contains zero or more key-value pairs where the key is the media type (eg "sms", "email", "jabber", etc) and the value is the address (ie mobile number, email address, jabber id etc).
* The "email" key in the CONTACT hash is not to be used for sending alerts, it is supplied as a qualification of the contact's identity only. Only the "email" key in the MEDIA hash, if present, is to be used for notifications.
* The value for ID must be unique and must never change as it is used for synchronisation during updates.
* The "pagerduty" hash may or may not be present. If absent, any existing pagerduty info for the contact will be removed on import.

Example - three contacts with varying media
```json
[
  {
    "id": "362",
    "first_name": "John",
    "last_name": "Johnson",
    "email": "johnj@example.com",
    "media": {
      "sms": "+61412345678",
      "email": "johnj@example.com"
    }
  },
  {
    "id": "363",
    "first_name": "Jane",
    "last_name": "Janeley",
    "email": "janej@example.com",
    "media": {
      "email": "janej@example.com"
    }
  },
  {
    "id": "364",
    "first_name": "Roger",
    "last_name": "Wilco",
    "email": "rogerw@example.com",
    "media": {
      "jabber": "roger@conference.example.com"
    }
  }
]
```

Example ruby code to construct this format:

```ruby
require 'yajl'

contacts = []

media = { :sms   => '+61412345678',
          :email => 'johnj@example.com' }

contact = { :id         => '362',
            :first_name => 'John',
            :last_name  => 'Johnson',
            :email      => 'johnj@example.com',
            :media      => media }

contacts.push(contact)


media = { :email => 'janej@example.com' }

contact = { :id         => '363',
            :first_name => 'Jane',
            :last_name  => 'Janeley',
            :email      => 'janej@example.com',
            :media      => media }

contacts.push(contact)


media = { :jabber => 'roger@conference.example.com' }

contact = { :id         => '364',
            :first_name => 'Roger',
            :last_name  => 'Wilco',
            :email      => 'rogerw@example.com',
            :media      => media }

contacts.push(contact)

puts Yajl::Encoder.encode(contacts, :pretty => true)
```



### Entities

The entities json import file is an array of entities as follows:

```
ENTITIES (array) = [ENTITY, ENTITY, ...]
ENTITY   (hash)  = { "id": ENTITY_ID, "name": NAME, "contacts": CONTACTS }
CONTACTS (array) = { CONTACT_ID, CONTACT_ID, ... }

ENTITY_ID     (string) - a unique, immutable identifier for this entity
CONTACT_ID    (string) - a unique identifier for each contact (key'd to CONTACT_ID in the contacts import)
NAME          (string) - name of the entity, eg a hostname / service identifier. Syntax rules for unqualified hostnames applies to this field (e.g. only alphanumeric, mustn't start with a number, etc.)
```

Example - three entities with a different selection of contacts interested in each

```json
[
  {
    "id": "10001",
    "name": "clientx-app-01",
    "contacts": [
      "362",
      "363",
      "364"
    ]
  },
  {
    "id": "10002",
    "name": "clientx-app-02",
    "contacts": [
      "362",
      "364"
    ]
  },
  {
    "id": "10003",
    "name": "clienty-app-01",
    "contacts": [
      "363",
      "364"
    ]
  }
]
```


Example code to construct this format:

```ruby
require 'yajl'

entities = []

contacts = ['362', '363', '364']
entity = { :id          => '10001',
           :name        => 'clientx-app-01',
           :contacts    => contacts }
entities.push(entity)

contacts = ['0362']
entity = { :id          => '10002',
           :name        => 'clientx-app-02',
           :contacts    => contacts }
entities.push(entity)

contacts = ['0363', '0364']
entity = { :id          => '10003',
           :name        => 'clienty-app-01',
           :contacts    => contacts }
entities.push(entity)

puts Yajl::Encoder.encode(entities, :pretty => true)
```






