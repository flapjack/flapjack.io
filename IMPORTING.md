## Importing contacts and entities (CLI)

The REST API and the `flapjack-populator` script provide a mechanisms for importing contacts and entities in JSON format. Here are some command line examples for `flapjack-populator`:

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
CONTACT   (hash)  = { "id": CONTACT_ID, "first_name": FIRST_NAME, "last_name": LAST_NAME,
                      "email": EMAIL, "media": MEDIA }
MEDIA     (hash)  = { MEDIA_TYPE: MEDIA_ADDRESS, MEDIA_TYPE: MEDIA_ADDRESS, "pagerduty": PAGERDUTY... }
PAGERDUTY (hash)  = { "service_key": PAGERDUTY_SERVICE_KEY, "subdomain": PAGERDUTY_SUBDOMAIN,
                      "username": PAGERDUTY_USERNAME, "password": PAGERDUTY_PASSWORD }
TAGS      (array) = ["TAG", "TAG", ...]

CONTACT_ID            (string) - a unique, immutable identifier for this contact
MEDIA_TYPE            (string) - one of "email", "sms", "jabber", or any other media type we add support for in the future
MEDIA_ADDRESS         (string) - address to send to for the paired MEDIA_TYPE, eg an email address, mobile phone number, or jabber id
PAGERDUTY_SERVICE_KEY (string) - the API key for PagerDuty's integration API, corresponds to a 'service' within this contact's PagerDuty account
PAGERDUTY_SUBDOMAIN   (string) - the subdomain for this contact's PagerDuty account, eg "companyname" in the case of https://companyname.pagerduty.com/
PAGERDUTY_USERNAME    (string) - the username for the PagerDuty REST API (basic http auth) for reading data back out of PagerDuty
PAGERDUTY_PASSWORD    (string) - the password for the PagerDuty REST API
TAG                   (string) - a tag, you know?
```

Notes:
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
    },
    "tags": [
      "source:titanium",
      "foo"
    ]
  },
  {
    "id": "363",
    "first_name": "Jane",
    "last_name": "Janeley",
    "email": "janej@example.com",
    "media": {
      "email": "janej@example.com"
    },
    "tags": [
      "source:titanium",
      "bar"
    ]
  },
  {
    "id": "364",
    "first_name": "Roger",
    "last_name": "Wilco",
    "email": "rogerw@example.com",
    "media": {
      "jabber": "roger@conference.example.com"
    },
    "tags": [
      "source:titanium",
      "bar",
      "foo"
    ]
  }
]
```

Example ruby code to construct this format:

```ruby
#!/usr/bin/env ruby

require 'yajl'

contacts = []

tags = [ 'source:titanium', 'foo']

media = { :sms   => '+61412345678',
          :email => 'johnj@example.com' }

contact = { :id         => '362',
            :first_name => 'John',
            :last_name  => 'Johnson',
            :email      => 'johnj@example.com',
            :media      => media,
            :tags       => tags }

contacts.push(contact)

puts Yajl::Encoder.encode(contacts, :pretty => true)
```

### Entities

The entities json import file is an array of entities as follows:

```
ENTITIES (array) = [ENTITY, ENTITY, ...]
ENTITY   (hash)  = { "id": "ENTITY_ID", "name": "NAME", "contacts": CONTACTS, "tags": TAGS }
CONTACTS (array) = { "CONTACT_ID", "CONTACT_ID", ... }
TAGS     (array) = [ "TAG", "TAG", ... ]


ENTITY_ID     (string) - a unique, immutable identifier for this entity
CONTACT_ID    (string) - a unique identifier for each contact (key'd to CONTACT_ID in the contacts import, surprise)
NAME          (string) - name of the entity, eg a hostname / service identifier. syntax rules for unqualified hostnames applies to this field (eg only alphanumeric, mustn't start with a number etc) TODO: actually, perhaps this needs to allow FQDNs? Essentially it needs to match up with whatever is put into the nagios check config.
TAG           (string) - a tag
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
    ],
    "tags": [
      "source:titanium",
      "foo"
    ]
  },
  {
    "id": "10002",
    "name": "clientx-app-02",
    "contacts": [
      "362"
    ],
    "tags": [
      "source:titanium",
      "bar"
    ]
  },
  {
    "id": "10003",
    "name": "clienty-app-01",
    "contacts": [
      "363",
      "364"
    ],
    "tags": [
      "source:titanium"
    ]
  }
]
```

Example code to construct this format:

```ruby
#!/usr/bin/env ruby

require 'yajl'

entities = []

contacts = ['362', '363', '364']
tags     = ["source:titanium", "foo"]
entity   = { :id          => '10001',
             :name        => 'clientx-app-01',
             :contacts    => contacts,
             :tags        => tags }
entities.push(entity)

contacts = ['362']
tags     = ["source:titanium", "bar"]
entity   = { :id          => '10002',
             :name        => 'clientx-app-02',
             :contacts    => contacts,
             :tags        => tags }
entities.push(entity)

contacts = ['363', '364']
tags     = ["source:titanium"]
entity = { :id          => '10003',
           :name        => 'clienty-app-01',
           :contacts    => contacts,
           :tags        => tags }
entities.push(entity)

puts Yajl::Encoder.encode(entities, :pretty => true)
```

## JSON format for API responses

The Flapjack API provides various views into its current state, history etc.

### Checks per Entity

For a given entity, return a list of all checks against this entity

```json
[{"name":"HOST",
  "state":"up",
  "in_unscheduled_maintenance":false,
  "in_scheduled_maintenance":false,
  "last_update":1345701755,
  "last_problem_notification":0,
  "last_recovery_notification":0,
  "last_acknowledgement_notification":0},
 {"name":"HTTP Port 443",
  "state":"ok",
  "in_unscheduled_maintenance":false,
  "in_scheduled_maintenance":false,
  "last_update":1345701757,
  "last_problem_notification":0,
  "last_recovery_notification":0,
  "last_acknowledgement_notification":0},
 {"name":"PING",
  "state":"ok",
  "in_unscheduled_maintenance":false,
  "in_scheduled_maintenance":false,
  "last_update":1345701757,
  "last_problem_notification":0,
  "last_recovery_notification":0,
  "last_acknowledgement_notification":0},
 {"name":"VMware MKS",
  "state":"ok",
  "in_unscheduled_maintenance":false,
  "in_scheduled_maintenance":false,
  "last_update":1345701757,
  "last_problem_notification":0,
  "last_recovery_notification":0,
  "last_acknowledgement_notification":0}
]
```

