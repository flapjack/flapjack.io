
API URLs
========

Flapjack's HTTP API currently provides the following queries, data import functions and actions:

<ul>
  <li><a href="#get_entities"> GET /entities</a></li>
  <li><a href="#get_checks"> GET /checks/ENTITY</a></li>
  <li><a href="#get_status"> GET /status/ENTITY[/CHECK]</a></li>
  <li><a href="#get_outages"> GET /outages/ENTITY[/CHECK]</a></li>
  <li><a href="#get_unscheduled_maintenances"> GET /unscheduled_maintenances/ENTITY[/CHECK]</a></li>
  <li><a href="#get_scheduled_maintenances">GET /scheduled_maintenances/ENTITY[/CHECK]</a></li>
  <li><a href="#get_downtime">GET /downtime/ENTITY[/CHECK]</a></li>
  <li><a href="#post_scheduled_maintenances">POST /scheduled_maintenances/ENTITY/CHECK</a></li>
  <li><a href="#post_acknowledgements">POST /acknowledgements/ENTITY/CHECK</a></li>
  <li><a href="#post_test_notifications">POST /test_notifications/ENTITY/CHECK</a></li>
  <li><a href="#post_entities">POST /entities</a></li>
  <li><a href="#post_contacts">POST /contacts</a></li>
</ul>

[Vapourware:](#vapourware)

<ul>
  <li><a href="#get_contacts">GET /contacts</a></li>
  <li><a href="#post_contacts_new">POST /contacts</a></li>
  <li><a href="#get_contacts_id">GET /contacts/CONTACT_ID</a></li>
  <li><a href="#get_contacts_id_notification_rules">GET /contacts/CONTACT_ID/notification_rules</a></li>
  <li><a href="#get_notification_rules_id">GET /notification_rules/RULE_ID</a></li>
  <li><a href="#post_notification_rules">POST /notification_rules</a></li>
  <li><a href="#put_notification_rules_id">PUT, DELETE /notification_rules/RULE_ID</a></li>
  <li><a href="#get_contacts_id_media">GET /contacts/CONTACT_ID/media</a></li>
  <li><a href="#get_contacts_id_media_media">GET /contacts/CONTACT_ID/media/MEDIA</a></li>
  <li><a href="#put_contacts_id_media_media">PUT, DELETE /contacts/CONTACT_ID/media/MEDIA</a></li>
  <li><a href="#get_contacts_id_timezone">GET /contacts/CONTACT_ID/timezone</a></li>
  <li><a href="#put_contacts_id_timezone">PUT, DELETE /contacts/CONTACT_ID/timezone</a></li>

  <li><a href="#get_contacts_id_tags">GET /contacts/CONTACT_ID/tags</a></li>
  <li><a href="#post_contacts_id_tags">POST /contacts/CONTACT_ID/tags</a></li>
  <li><a href="#delete_contacts_id_tags">DELETE /contacts/CONTACT_ID/tags</a></li>

  <li><a href="#get_contacts_id_entitytags">GET /contacts/CONTACT_ID/entity_tags</a></li>
  <li><a href="#post_contacts_id_entitytags">POST /contacts/CONTACT_ID/entity_tags</a></li>
  <li><a href="#delete_contacts_id_entitytags">DELETE /contacts/CONTACT_ID/entity_tags</a></li>

  <li><a href="#get_entities_id_tags">GET /entities/ENTITY/tags</a></li>
  <li><a href="#post_entities_id_tags">POST /entities/ENTITY/tags</a></li>
  <li><a href="#delete_entities_id_tags">DELETE /entities/ENTITY/tags</a></li>
</ul>

See also the [flapjack-diner](https://github.com/flpjck/flapjack-diner/) gem which provides a ruby consumer of this API.

### Query Paramaters

Some of the GET queries can take some optional query string parameters as follows:

<table>
  <tr>
    <th>parameter </th>
    <th>description </th>
  </tr>
  <tr>
    <td>start_time </td>
    <td>start time of the period in ISO 8601 format, eg 2013-02-22T15:39:39+11:00. Absence means 'beginning of time'. </td>
  </tr>
  <tr>
    <td>end_time   </td>
    <td>end time of the period in ISO 8601 format. Absence means 'end of days'.</td>
  </tr>
</table>

<a id="get_entities">&nbsp;</a>
### GET /entities
Retrieve an array of all entities including core attributes and state of any checks on the entity.

**Output JSON Format**
```text
ENTITIES (array) = [ENTITY, ENTITY, ...]
ENTITY    (hash) = { "id": "ENTITY_ID", "name": "NAME", "checks": CHECKS }
CHECKS   (array) = [ CHECK, CHECK, ... ]
CHECK     (hash) = { "name": "CHECK_NAME",
                     "state": "CHECK_STATE",
                     "in_unscheduled_maintenance": BOOLEAN,
                     "in_scheduled_maintenance": BOOLEAN,
                     "last_update": TIMESTAMP,
                     "last_problem_notification": TIMESTAMP,
                     "last_recovery_notification": TIMESTAMP,
                     "last_acknowledgement_notification": TIMESTAMP }

TIMESTAMP: unix timestamp (number of seconds since 1 January 1970, UTC)
BOOLEAN:   one of 'true' or 'false'
```

**Example**
```bash
curl http://localhost:4091/entities
```
**Response** Status: 200 OK
```json
[
   {
      "checks" : [
         {
            "last_recovery_notification" : null,
            "last_acknowledgement_notification" : null,
            "last_update" : 1356853261,
            "name" : "HOST",
            "last_problem_notification" : null,
            "in_scheduled_maintenance" : false,
            "in_unscheduled_maintenance" : false,
            "state" : "ok"
         },
         {
            "last_recovery_notification" : null,
            "last_acknowledgement_notification" : null,
            "last_update" : 1356853261,
            "name" : "HTTP Port 443",
            "last_problem_notification" : 1356853151,
            "in_scheduled_maintenance" : false,
            "in_unscheduled_maintenance" : false,
            "state" : "critical"
         }
      ],
      "name" : "client1-localhost-test-2",
      "id" : "10002"
   }
]
```

<a id="get_checks">&nbsp;</a>
### GET /checks/ENTITY
Retrieve the names of the checks for the specified entity.

**Output JSON Format**
```text
CHECKS   (array) = [ CHECK_NAME, CHECK_NAME, ... ]
```

**Example**
```bash
curl http://localhost:4091/checks/client1-localhost-test-2
```
**Response** Status: 200 OK
```json
[
   "HOST",
   "HTTP Port 443"
]
```

<a id="get_status">&nbsp;</a>
### GET /status/ENTITY[/CHECK]
Get the status of the specified check, or for all checks of the specified entity if no check is given.

**Output JSON Format**
```text
CHECKS   (array) = [ CHECK, CHECK, ... ]
CHECK     (hash) = { "name": "CHECK_NAME",
                     "state": "CHECK_STATE",
                     "in_unscheduled_maintenance": BOOLEAN,
                     "in_scheduled_maintenance": BOOLEAN,
                     "last_update": TIMESTAMP,
                     "last_problem_notification": TIMESTAMP,
                     "last_recovery_notification": TIMESTAMP,
                     "last_acknowledgement_notification": TIMESTAMP }

TIMESTAMP: unix timestamp (number of seconds since 1 January 1970, UTC)
BOOLEAN:   one of 'true' or 'false'
```

**Example 1**
```bash
curl http://localhost:4091/status/client1-localhost-test-2
```
**Response** Status: 200 OK
```json
[
   {
      "last_recovery_notification" : null,
      "last_acknowledgement_notification" : null,
      "last_update" : 1356853261,
      "name" : "HOST",
      "last_problem_notification" : null,
      "in_scheduled_maintenance" : false,
      "in_unscheduled_maintenance" : false,
      "state" : "ok"
   },
   {
      "last_recovery_notification" : null,
      "last_acknowledgement_notification" : null,
      "last_update" : 1356853261,
      "name" : "HTTP Port 443",
      "last_problem_notification" : 1356853151,
      "in_scheduled_maintenance" : false,
      "in_unscheduled_maintenance" : false,
      "state" : "critical"
   }
]
```

**Example 2**
```bash
curl http://localhost:4091/status/client1-localhost-test-2/HTTP%20Port%20443
```
**Response** Status: 200 OK
```json
 {
    "last_recovery_notification" : null,
    "last_acknowledgement_notification" : null,
    "last_update" : 1356853261,
    "name" : "HTTP Port 443",
    "last_problem_notification" : 1356853151,
    "in_scheduled_maintenance" : false,
    "in_unscheduled_maintenance" : false,
    "state" : "critical"
 }
```

<a id="get_outages">&nbsp;</a>
### GET /outages/ENTITY[/CHECK]

**Optional parameters:** _start_time, end_time_

**Output JSON Format**
```text
CHECKS   (array) = [ CHECK, CHECK, ... ]
CHECK     (hash) = { "check": "CHECK_NAME",
                     "outages": OUTAGES }
OUTAGES  (array) = [ OUTAGE, OUTAGE, ... ]
OUTAGE    (hash) = { "start_time": TIMESTAMP,
                     "end_time": TIMESTAMP,
                     "duration": DURATION,
                     "state": "STATE",
                     "summary": "SUMMARY" }

TIMESTAMP: unix timestamp (number of seconds since 1 January 1970, UTC)
DURATION: period of time in seconds, integer
```

Get the list of outages for the specified check, or for all checks of the specified entity if no check is given.

**Example 1**
```bash
curl http://localhost:4091/outages/client1-localhost-test-2
```
**Response** Status: 200 OK
```json
[
   {
      "check" : "HOST",
      "outages" : [
         {
            "end_time" : 1355958411,
            "summary" : "(Host Check Timed Out)",
            "start_time" : 1355958401,
            "duration" : 10,
            "state" : "critical"
         },
         {
            "end_time" : 1356562502,
            "summary" : "(Host Check Timed Out)",
            "start_time" : 1356562492,
            "duration" : 10,
            "state" : "critical"
         }
      ]
   },
   {
      "check" : "HTTP Port 443",
      "outages" : [
         {
            "end_time" : null,
            "summary" : "Connection refused",
            "start_time" : 1355917335,
            "duration" : null,
            "state" : "critical"
         }
      ]
   }
]
```
**Example 2**
```bash
curl http://localhost:4091/outages/client1-localhost-test-2/HOST?start_time=2012-12-24T00:00:00Z
```
**Response** Status: 200 OK
```json
[
   {
      "end_time" : 1356562502,
      "summary" : "(Host Check Timed Out)",
      "start_time" : 1356562492,
      "duration" : 10,
      "state" : "critical"
   }
]
```

<a id="get_unscheduled_maintenances">&nbsp;</a>
### GET /unscheduled_maintenances/ENTITY[/CHECK]

**Optional parameters:** _start_time, end_time_

**Output JSON Format**
```text
CHECKS   (array) = [ CHECK, CHECK, ... ]
CHECK     (hash) = { "check": "CHECK_NAME",
                     "unscheduled_maintenance": MAINTS }
MAINTS   (array) = [ MAINT, MAINT, ... ]
MAINT     (hash) = { "start_time": TIMESTAMP,
                     "end_time": TIMESTAMP,
                     "duration": DURATION,
                     "summary": "SUMMARY" }

TIMESTAMP: unix timestamp (number of seconds since 1 January 1970, UTC)
DURATION: period of time in seconds, integer
```

Get the list of unscheduled maintenance periods for the specified check, or for all checks of the specified entity if no check is given.

**Example**
```bash
curl http://localhost:4091/unscheduled_maintenances/client1-localhost-test-1
```
**Response** Status: 200 OK
```json
[
   {
      "check" : "HOST",
      "unscheduled_maintenance" : []
   },
   {
      "check" : "HTTP Port 443",
      "unscheduled_maintenance" : [
         {
            "end_time" : 1356067056,
            "summary" : "- JR looking",
            "start_time" : 1356044450,
            "duration" : 22606
         }
      ]
   }
]
```

<a id="get_scheduled_maintenances">&nbsp;</a>
### GET /scheduled_maintenances/ENTITY[/CHECK]

**Optional parameters:** _start_time, end_time_

**Output JSON Format**
```text
CHECKS   (array) = [ CHECK, CHECK, ... ]
CHECK     (hash) = { "check": "CHECK_NAME",
                     "scheduled_maintenance": MAINTS }
MAINTS   (array) = [ MAINT, MAINT, ... ]
MAINT     (hash) = { "start_time": TIMESTAMP,
                     "end_time": TIMESTAMP,
                     "duration": DURATION,
                     "summary": "SUMMARY" }

TIMESTAMP: unix timestamp (number of seconds since 1 January 1970, UTC)
DURATION: period of time in seconds, integer
```

Get the list of scheduled maintenance periods for the specified check, or for all checks of the specified entity if no check is given.

**Example**
```bash
curl http://localhost:4091/scheduled_maintenances/client1-localhost-test-2
```
**Response** Status: 200 OK
```json
[
   {
      "check" : "HOST",
      "scheduled_maintenance" : []
   },
   {
      "check" : "HTTP Port 443",
      "scheduled_maintenance" : []
   }
]
```

<a id="get_downtime">&nbsp;</a>
### GET /downtime/ENTITY[/CHECK]

**Optional parameters:** _start_time, end_time_

Get the list of downtimes for the specified check, or for all checks of the specified entity if no check is given. Downtime is outages minus scheduled maintenances across any given time period (See [the glossary](GLOSSARY)). The total seconds of downtime, and the corresponding percentage, are calculated and included in the results.

Note that a start_time and end_time must be specified in order for the percentages to be calculated.

**Output JSON Format**
```text
CHECKS     (array)  = [ CHECK, CHECK, ... ]
CHECK       (hash)  = { "check": "CHECK_NAME",
                        "downtime": DOWNTIME }
DOWNTIME    (hash)  = { "downtime": PERIODS,
                        "percentages": PERCENTAGES,
                        "total_seconds": TOTAL_SECONDS }
PERIODS     (array) = [ PERIOD, PERIOD, ... ]
PERIOD       (hash) = { "start_time": TIMESTAMP,
                        "end_time": TIMESTAMP,
                        "duration": DURATION,
                        "state": "STATE",
                        "summary": "SUMMARY" }
PERCENTAGES   (hash) = { "ok": PERCENTAGE,
                         "warning": PERCENTAGE,
                         "critical": PERCENTAGE,
                         "unknown": PERCENTAGE }
TOTAL_SECONDS (hash) = { "ok": DURATION,
                         "warning": DURATION,
                         "critical": DURATION,
                         "unknown": DURATION }

PERCENTAGE: floating point number between 0 and 100 representing a percentage
TIMESTAMP: unix timestamp (number of seconds since 1 January 1970, UTC)
DURATION: period of time in seconds, integer
STATE: one of 'ok', 'warning', 'critical', or 'unknown'
```

**Notes:**
* the states under PERCENTAGES and TOTAL_SECONDS may be omitted if they are zero.
* the non-ok states under PERCENTAGES and TOTAL_SECONDS represent total downtime for this state.
* the ok state time is calculated as: total report period - sum of non OK downtime durations

**Example**
```bash
curl "http://localhost:4091/downtime/client1-localhost-test-2/HOST?start_time=2012-12-01T00:00:00Z&end_time=2013-01-01T00:00:00Z"
```
**Response** Status: 200 OK
```json
{
   "downtime" : [
      {
         "end_time" : 1355958411,
         "summary" : "(Host Check Timed Out)",
         "start_time" : 1355958401,
         "duration" : 10,
         "state" : "critical"
      },
      {
         "end_time" : 1356562502,
         "summary" : "(Host Check Timed Out)",
         "start_time" : 1356562492,
         "duration" : 10,
         "state" : "critical"
      }
   ],
   "percentages" : {
      "ok" : 99.9992532855436,
      "critical" : 0.000746714456391876
   },
   "total_seconds" : {
      "ok" : 2678380,
      "critical" : 20
   }
}
```

<a id="post_scheduled_maintenances">&nbsp;</a>
### POST /scheduled_maintenances/ENTITY/CHECK'
Creates scheduled maintenance for the specified check.

**Input JSON Format**
```text
MAINT (hash) = { "start_time": TIMESTAMP,
                 "duration": DURATION,
                 "summary": "SUMMARY" }
```

**Example**
```bash
curl -w 'response: %{http_code} \n' -X POST -H "Content-type: application/json" -d \
 '{
    "start_time": 1361791228,
    "duration": 3600,
    "summary": "SHUT IT ALL DOWN!"
  }' \
 http://localhost:4091/scheduled_maintenances/client1-localhost-test-2/HOST
```
**Response** Status: 204 (No Content)

<a id="post_acknowledgements">&nbsp;</a>
### POST /acknowledgements/ENTITY/CHECK'
Acknowledges a problem on the specified check and creates unscheduled maintenance. 4 hrs is the default period but can be specied in the body. An optional message may also be supplied.

**Input JSON Format**
```text
ACK (hash) = { "duration": DURATION,
               "summary": "SUMMARY" }
```

**Example**
```bash
curl -w 'response: %{http_code} \n' -X POST -H "Content-type: application/json" -d \
 '{
    "duration": 3600,
    "summary": "AL - working on it"
  }' \
 http://localhost:4091/acknowledgements/client1-localhost-test-2/HOST
```
**Response** Status: 204 (No Content)

<a id="post_test_notifications">&nbsp;</a>
### POST /test_notifications/ENTITY/CHECK
Generates test notifications for the specified check. Body can be left empty.

**Example**
```bash
curl -X POST "http://localhost:4091/test_notifications/client1-localhost-test-2/HOST"
```

**Response** Status: 204 No Content

<a id="post_entities">&nbsp;</a>
### POST /entities
Creates or updates entities from the supplied entities, using id as key.

**Input JSON Format**
```text
ENTITIES (array) = [ ENTITY, ENTITY, ...]
ENTITY   (hash)  = { "id": "ENTITY_ID",
                     "name": "NAME",
                     "contacts": CONTACTS,
                     "tags": TAGS }
CONTACTS (array) = [ "CONTACT_ID", "CONTACT_ID", ... ]
TAGS     (array) = [ "TAG", "TAG", ... ]


ENTITY_ID     (string) - a unique, immutable identifier for this entity
CONTACT_ID    (string) - a unique identifier for each contact (key'd to CONTACT_ID in the contacts import, surprise)
NAME          (string) - name of the entity, eg a hostname / service identifier. syntax rules for hostnames (qualified or no) applies to this field, refer RFC 1123. This needs to match up with whatever is put into the check execution configuration, eg FQDN.
TAG           (string) - a tag
```

**Example**
```bash
curl -w 'response: %{http_code} \n' -X POST -H "Content-type: application/json" -d \
 '{
    "entities": [
      {
        "id": "825",
        "name": "foo.example.com",
        "contacts": [
          "21",
          "22"
        ],
        "tags": [
          "foo"
        ]
      }
    ]
  }' \
 http://localhost:4091/entities
```
**Response** Status: 200 OK

<a id="post_contacts">&nbsp;</a>
### POST /contacts
Deletes all contacts before importing the supplied contacts.

**Note:** this is changing. See the new design under the vapourware section, below.

**Input JSON Format**
```text
CONTACTS  (array) = [ CONTACT, CONTACT, ...]
CONTACT   (hash)  = { "id": CONTACT_ID, "first_name": FIRST_NAME, "last_name": LAST_NAME,
                      "email": EMAIL, "media": MEDIA }
MEDIA     (hash)  = { MEDIA_TYPE: MEDIA_ADDRESS, MEDIA_TYPE: MEDIA_ADDRESS, "pagerduty": PAGERDUTY... }
PAGERDUTY (hash)  = { "service_key": PAGERDUTY_SERVICE_KEY, "subdomain": PAGERDUTY_SUBDOMAIN,
                      "username": PAGERDUTY_USERNAME, "password": PAGERDUTY_PASSWORD }
TAGS      (array) = [ "TAG", "TAG", ...]

CONTACT_ID            (string) - a unique, immutable identifier for this contact
MEDIA_TYPE            (string) - one of "email", "sms", "jabber", or any other media type we add support for in the future
MEDIA_ADDRESS         (string) - address to send to for the paired MEDIA_TYPE, eg an email address, mobile phone number, or jabber id
PAGERDUTY_SERVICE_KEY (string) - the API key for PagerDuty's integration API, corresponds to a 'service' within this contact's PagerDuty account
PAGERDUTY_SUBDOMAIN   (string) - the subdomain for this contact's PagerDuty account, eg "companyname" in the case of https://companyname.pagerduty.com/
PAGERDUTY_USERNAME    (string) - the username for the PagerDuty REST API (basic http auth) for reading data back out of PagerDuty
PAGERDUTY_PASSWORD    (string) - the password for the PagerDuty REST API
TAG                   (string) - a tag, you know?
```

**Notes:**
* The MEDIA hash contains zero or more key-value pairs where the key is the media type (eg "sms", "email", "jabber", etc) and the value is the address (ie mobile number, email address, jabber id etc).
* The "email" key in the CONTACT hash is not to be used for sending alerts, it is supplied as a qualification of the contact's identity only. Only the "email" key in the MEDIA hash, if present, is to be used for notifications.
* The value for ID must be unique and must never change as it is used for synchronisation during updates.
* The "pagerduty" hash may or may not be present. If absent, any existing pagerduty info for the contact will be removed on import.

**Example**
```bash
curl -w 'response: %{http_code} \n' -X POST -H "Content-type: application/json" -d \
 '{
    "contacts": [
      {
        "id": "21",
        "first_name": "Ada",
        "last_name": "Lovelace",
        "email": "ada@example.com",
        "media": {
          "sms": "+61412345678",
          "email": "ada@example.com"
        },
        "tags": [
          "legend",
          "first computer programmer"
        ]
      }
    ]
  }' \
 http://localhost:4091/contacts
```
**Response** Status: 200 OK

<a id="vapourware">&nbsp;</a>
## Warning: Vapourware Follows!

The following API interactions are in the design phase and are likely to change before and/or during implementation.

<a id="get_contacts">&nbsp;</a>
### GET /contacts

Returns all the contacts

**Example**
```bash
curl http://localhost:4091/contacts
```

```json
[
  {
    "id": "21",
    "first_name": "Ada",
    "last_name": "Lovelace",
    "email": "ada@example.com",
    "tags": [
      "legend",
      "first computer programmer"
    ]
  },
  {
    "id": "22",
    "first_name": "Charles",
    "last_name": "Babbage",
    "email": "babbage@example.com",
    "tags": [
      "grump"
    ]
  }
]
```

<a id="post_contacts_new">&nbsp;</a>
### POST /contacts
Deletes all contacts before importing the supplied contacts.

**Note:** this is an incompable modification of the former interface (v0.6.1 and prior)

**Input JSON Format**
```text
CONTACTS  (array) = [ CONTACT, CONTACT, ...]
CONTACT   (hash)  = { "id": CONTACT_ID, "first_name": FIRST_NAME, "last_name": LAST_NAME,
                      "email": EMAIL, "media": MEDIAS }
MEDIAS    (hash)  = { MEDIA_TYPE: MEDIA, MEDIA_TYPE: MEDIA, "pagerduty": PAGERDUTY... }
MEDIA     (hash)  = { "address": MEDIA_ADDRESS,
                      "interval": INTERVAL }
PAGERDUTY (hash)  = { "service_key": PAGERDUTY_SERVICE_KEY, "subdomain": PAGERDUTY_SUBDOMAIN,
                      "username": PAGERDUTY_USERNAME, "password": PAGERDUTY_PASSWORD }
TAGS      (array) = [ "TAG", "TAG", ...]

CONTACT_ID            (string) - a unique, immutable identifier for this contact
MEDIA_TYPE            (string) - one of "email", "sms", "jabber", or any other media type we add support for in the future
MEDIA_ADDRESS         (string) - address to send to for the paired MEDIA_TYPE, eg an email address, mobile phone number, or jabber id
PAGERDUTY_SERVICE_KEY (string) - the API key for PagerDuty's integration API, corresponds to a 'service' within this contact's PagerDuty account
PAGERDUTY_SUBDOMAIN   (string) - the subdomain for this contact's PagerDuty account, eg "companyname" in the case of https://companyname.pagerduty.com/
PAGERDUTY_USERNAME    (string) - the username for the PagerDuty REST API (basic http auth) for reading data back out of PagerDuty
PAGERDUTY_PASSWORD    (string) - the password for the PagerDuty REST API
TAG                   (string) - a tag, you know?
INTERVAL              (string) - number of seconds to repeat the same alert on this media type
```

**Notes:**
* The "email" key in the CONTACT hash is not to be used for sending alerts, it is supplied as a qualification of the contact's identity only. Only the "email" key in the MEDIA hash, if present, is to be used for notifications.
* The value for ID must be unique and must never change as it is used for synchronisation during updates.
* The "pagerduty" hash may or may not be present. If absent, any existing pagerduty info for the contact will be removed on import.

**Example**
```bash
curl -w 'response: %{http_code} \n' -X POST -H "Content-type: application/json" -d \
 '{
    "contacts": [
      {
        "id": "21",
        "first_name": "Ada",
        "last_name": "Lovelace",
        "email": "ada@example.com",
        "media": {
          "sms": {
            "address": "+61412345678",
            "interval": "3600"
          },
          "email": {
            "address": "ada@example.com",
            "interval": "7200"
          }
        },
        "tags": [
          "legend",
          "first computer programmer"
        ]
      }
    ]
  }' \
 http://localhost:4091/contacts
```
**Response** Status: 200 OK


<a id="get_contacts_id">&nbsp;</a>
### GET /contacts/CONTACT_ID

Returns the core information of a specified contact.

**Example**
```bash
curl http://localhost:4091/contacts/21
```

```json
{
  "id": "21",
  "first_name": "Ada",
  "last_name": "Lovelace",
  "email": "ada@example.com",
  "tags": [
    "legend",
    "first computer programmer"
  ]
}
```

<a id="get_contacts_id_notification_rules">&nbsp;</a>
### GET /contacts/CONTACT_ID/notification_rules

Lists a contact's notification rules.

**Example**
```bash
curl http://localhost:4091/contacts/21/notification_rules
```
**Response** Status: 200 OK
```json
[
  {
    "id": "08f607c7-618d-460a-b3fe-868464eb6045",
    "contact_id": "21",
    "entity_tags": [
      "database",
      "physical"
    ],
    "entities": [
      "foo-app-01.example.com"
    ],
    "time_restrictions": [
      {
        "summary": "Weekly on Weekdays",
        "start_time": "2013-01-28 08:00:00",
        "end_time": "2013-01-28 18:00:00",
        "rrules": [
          {
            "validations": {
              "day": [1,2,3,4,5]
            },
            "rule_type": "Weekly",
            "interval": 1,
            "week_start": 0
          }
        ],
        "exrules": [],
        "rtimes": [],
        "extimes": []
      }
    ],
    "warning_media": [
      "email"
    ],
    "critical_media": [
      "sms",
      "email"
    ],
    "warning_blackhole": false,
    "critical_blackhole": false
  },
  {
    "id": "2be654d8-9ad4-42b7-963d-f6727dc302a2",
    "contact_id": "21",
    "entity_tags": [
      "database",
      "physical"
    ],
    "entities": [
      "foo-app-02.example.com"
    ],
    "time_restrictions": [],
    "warning_media": [
      "email"
    ],
    "critical_media": [
      "sms",
      "email"
    ],
    "warning_blackhole": false,
    "critical_blackhole": false
  }
]
```

<a id="get_notification_rules_id">&nbsp;</a>
### GET /notification_rules/RULE_ID

Returns a specified notification rule.

**Example**
```bash
curl -w 'response: %{http_code} \n' http://localhost:4091/notification_rules/08f607c7-618d-460a-b3fe-868464eb6045
```
**Response** Status: 200 OK
```json
{
  "id": "08f607c7-618d-460a-b3fe-868464eb6045",
  "contact_id": "21",
  "entity_tags": [
    "database",
    "physical"
  ],
  "entities": [
    "foo-app-01.example.com"
  ],
  "time_restrictions": [
    {
      "summary": "Weekly on Weekdays",
      "start_time": "2013-01-28 08:00:00",
      "end_time": "2013-01-28 18:00:00",
      "rrules": [
        {
          "validations": {
            "day": [1,2,3,4,5]
          },
          "rule_type": "Weekly",
          "interval": 1,
          "week_start": 0
        }
      ],
      "exrules": [],
      "rtimes": [],
      "extimes": []
    }
  ],
  "warning_media": [
    "email"
  ],
  "critical_media": [
    "sms",
    "email"
  ],
  "warning_blackhole": false,
  "critical_blackhole": false
}
```

<a id="post_notification_rules">&nbsp;</a>
### POST /notification_rules

Creates a new notification rule.

**Example**
```bash
curl -w 'response: %{http_code} \n' -X POST -H "Content-type: application/json" -d \
 '{
    "contact_id": "21",
    "entity_tags": [
      "database",
      "physical"
    ],
    "entities": [
      "foo-app-01.example.com"
    ],
    "time_restrictions": [
      {
        "start_time": "2013-01-28 08:00:00",
        "end_time": "2013-01-28 18:00:00",
        "rrules": [
          {
            "validations": {
              "day": [1,2,3,4,5]
            },
            "rule_type": "Weekly",
            "interval": 1,
            "week_start": 0
          }
        ],
        "exrules": [],
        "rtimes": [],
        "extimes": []
      }
    ],
    "warning_media": [
      "email"
    ],
    "critical_media": [
      "sms",
      "email"
    ],
    "warning_blackhole": false,
    "critical_blackhole": false
  }' \
 http://localhost:4091/notification_rules
```
**Response** Status: 200 OK

Returns the notification rule object as per GET.

**Notes:**
* the rule_id will be generated by flapjack as a UUID and supplied in the response body along with the rest of the contact's information
* time_restrictions are implemented within flapjack by the ice_cube gem, which is an implementation of the iCalendar RFC for Ruby. The interface we're exposing is close to ice_cube's hash representation of a schedule.
* in time_restrictions, the start_time and end_time should contain no timezone information, or UTC offset. They will be interpreted by flapjack as being in the user's local timezone, or the timezone configured in executive/default_contact_timezone in the flapjack configuration.
* in time_restrictions, the day validations are numbers corresponding to days of the week, as per the UNIX crontab file. Week days start on Sunday - 0, and progress through to Saturday - 6. So a day validation of "[1,2,3,4,5]" means Monday through Friday.
* time_restrictions rule_type specifies on what basis the time restriction schedule is to be repeated. It can be one of "Secondly", "Minutely", "Hourly", "Daily", "Weekly", "Monthly", or "Yearly".

<a id="put_notification_rules_id">&nbsp;</a>
### PUT, DELETE /notification_rules/RULE_ID

Updates or deletes a notification rule

**Example**
```bash
curl -w 'response: %{http_code} \n' -X PUT -H "Content-type: application/json" -d \
 '{
    "entity_tags": [
      "database",
      "physical"
    ],
    "entities": [
      "foo-app-01.example.com"
    ],
    "time_restrictions": [
      {
        "start_time": "2013-01-28 08:00:00",
        "end_time": "2013-01-28 18:00:00",
        "rrules": [
          {
            "validations": {
              "day": [1,2,3,4,5]
            },
            "rule_type": "Weekly",
            "interval": 1,
            "week_start": 0
          }
        ],
        "exrules": [],
        "rtimes": [],
        "extimes": []
      }
    ],
    "warning_media": [
      "email"
    ],
    "critical_media": [
      "sms",
      "email"
    ],
    "warning_blackhole": false,
    "critical_blackhole": false
  }' \
 http://localhost:4091/notification_rules/08f607c7-618d-460a-b3fe-868464eb6045
```
**Response** Status: 200 OK

Returns the notification rule object as per GET.

**Example 2 - DELETE**
```bash
curl -w 'response: %{http_code} \n' -X DELETE \
 http://localhost:4091/notification_rules/08f607c7-618d-460a-b3fe-868464eb6045
```
**Response** Status: 204 OK

<a id="get_contacts_id_media">&nbsp;</a>
### GET /contacts/CONTACT_ID/media

Returns the media of a contact.

Includes media type, address, and interval.

**Example**
```bash
curl -w 'response: %{http_code} \n' \
 http://localhost:4091/contacts/21/media
```



<a id="get_contacts_id_media_media">&nbsp;</a>
### GET /contacts/CONTACT_ID/media/MEDIA

Returns the specified media of a contact.


<a id="put_contacts_id_media_media">&nbsp;</a>
### PUT, DELETE /contacts/CONTACT_ID/media/MEDIA

Creates or updates (PUT) or deletes (DELETE) a media of a contact

**Example 1 - PUT**
```bash
curl -w 'response: %{http_code} \n' -X PUT -H "Content-type: application/json" -d \
 '{
    "address": "dmitri@example.com",
    "interval": 900
  }' \
 http://localhost:4091/contacts/21/media/email
```
**Response** Status: 200 OK
```json
{
  "address": "dmitri@example.com",
  "interval": 900
}
```

**Example 2 - DELETE**
```bash
curl -w 'response: %{http_code} \n' -X DELETE \
 http://localhost:4091/contacts/21/media/pagerduty
```
**Response** Status: 204 OK


**Notes:**
* any missing attributes in an update will remove those attributes (eg interval)
* address can't be removed and will cause a validation error

<a id="get_contacts_id_timezone">&nbsp;</a>
### GET /contacts/CONTACT_ID/timezone

Returns the timezone of a contact.

**Example**
```bash
curl -w 'response: %{http_code} \n' http://localhost:4091/contacts/21/timezone
```

**Response** Status: 200 OK
```json
{
  "timezone": "Australia/Broken_Hill"
}
```
FIXME: too much repetition to have the response include the key name "timezone"? Perhaps just return a string?

<a id="put_contacts_id_timezone">&nbsp;</a>
### PUT, DELETE /contacts/CONTACT_ID/timezone

Sets (PUT) or deletes (DELETE) the timezone of a contact.

**Example**
```bash
curl -w 'response: %{http_code} \n' -X PUT -H "Content-type: application/json" -d \
 '{
    "timezone": "Australia/Broken_Hill"
  }' \
 http://localhost:4091/contacts/21/timezone
```

**Response** Status: 200 OK
```json
{
  "timezone": "Australia/Broken_Hill"
}
```

**Notes:**
* the timezone string must be one defined in the tzinfo database, see: http://www.twinsun.com/tz/tz-link.htm, http://tzinfo.rubyforge.org/doc/



<a name="get_contacts_id_tags">&nbsp;</a>
### GET /contacts/CONTACT_ID/tags

Gets the tags for a contact.

**Example**
```bash
curl http://localhost:4091/contacts/21/tags
```
**Response** Status: 200 OK
```json
["user", "admin"]
```

<a name="post_contacts_id_tags">&nbsp;</a>
### POST /contacts/CONTACT_ID/tags

Add tags to a contact.

**Example 1 - JSON params**
```bash
curl -w 'response: %{http_code} \n' -X POST -H "Content-type: application/json" -d \
 '{
    "tag": ["admin", "user"]
  }' \
 http://localhost:4091/contacts/21/tags
 ```
**Example 2 - URL params**
```bash
curl -w 'response: %{http_code} \n' -X POST \
 "http://localhost:4091/contacts/21/tags?tag\[\]=admin&tag\[\]=user"
```
**Response** Status: 200 OK
```json
["user", "admin"]
```

<a name="delete_contacts_id_tags">&nbsp;</a>
### DELETE /contacts/CONTACT_ID/tags

Delete tags from a contact.

**Example 1 - JSON params**
```bash
curl -w 'response: %{http_code} \n' -X DELETE -H "Content-type: application/json" -d \
 '{
    "tag": ["admin", "user"]
  }' \
 http://localhost:4091/contacts/21/tags
 ```
**Example 2 - URL params**
```bash
curl -w 'response: %{http_code} \n' -X DELETE \
 "http://localhost:4091/contacts/21/tags?tag\[\]=admin&tag\[\]=user"
```
**Response** Status: 204 No Content

<a name="get_contacts_id_entitytags">&nbsp;</a>
### GET /contacts/CONTACT_ID/entity_tags

Gets the tags for all entities linked to a contact.

**Example**
```bash
curl http://localhost:4091/contacts/21/entity_tags
```
**Response** Status: 200 OK
```json
{"client1-localhost-test-1" : ["example", "app"],
 "client1-localhost-test-2" : ["example", "database"]}
```

<a name="post_contacts_id_entitytags">&nbsp;</a>
### POST /contacts/CONTACT_ID/entity_tags

Add tags to entities linked to a contact.

**Example 1 - JSON params**
```bash
curl -w 'response: %{http_code} \n' -X POST -H "Content-type: application/json" -d \
 '{
    "entity": {"client1-localhost-test-1" : ["decommission", "unneeded"],
               "client1-localhost-test-2" : ["upgrade"]}
  }' \
 http://localhost:4091/contacts/21/entity_tags
```
**Example 2 - URL params**
```bash
curl -w 'response: %{http_code} \n' -X POST \
 "http://localhost:4091/contacts/21/entity_tags?entity\[client1-localhost-test-1\]=decommission&entity\[client1-localhost-test-1\]=unneeded&entity\[client1-localhost-test-2\]=upgrade"
```
**Response** Status: 200 OK
```json
{"client1-localhost-test-1" : ["example", "app", "decommission", "unneeded"],
 "client1-localhost-test-2" : ["example", "database", "upgrade"]}
```

<a name="delete_contacts_id_entitytags">&nbsp;</a>
### DELETE /contacts/CONTACT_ID/entity_tags

Delete tags from entities linked to a contact.

**Example 1 - JSON params**
```bash
curl -w 'response: %{http_code} \n' -X DELETE -H "Content-type: application/json" -d \
 '{
    "entity": {"client1-localhost-test-1" : ["unneeded"],
               "client1-localhost-test-2" : ["upgrade"]}
  }' \
 http://localhost:4091/contacts/21/entity_tags
```
**Example 2 - URL params**
```bash
curl -w 'response: %{http_code} \n' -X DELETE \
 "http://localhost:4091/contacts/21/entity_tags?entity\[client1-localhost-test-1\]=unneeded&entity\[client1-localhost-test-2\]=upgrade"
```
**Response** Status: 204 No Content

<a name="get_entities_id_tags">&nbsp;</a>
### GET /entities/ENTITY/tags

Gets the tags for a entity.

**Example**
```bash
curl http://localhost:4091/entities/client1-localhost-test-1/tags
```
**Response** Status: 200 OK
```json
["web", "app"]
```

<a name="post_entities_id_tags">&nbsp;</a>
### POST /entities/ENTITY/tags

Add tags to an entity.

**Example 1 - JSON params**
```bash
curl -w 'response: %{http_code} \n' -X POST -H "Content-type: application/json" -d \
 '{
    "tag": ["web", "app"]
  }' \
 http://localhost:4091/entities/client1-localhost-test-1/tags
 ```
**Example 2 - URL params**
```bash
curl -w 'response: %{http_code} \n' -X POST \
 "http://localhost:4091/entities/client1-localhost-test-1/tags?tag\[\]=web&tag\[\]=app"
```
**Response** Status: 200 OK
```json
["web", "app"]
```

Add tags to an entity.

<a name="delete_entities_id_tags">&nbsp;</a>
### DELETE /entities/ENTITY/tags

Delete tags from an entity.

**Example 1 - JSON params**
```bash
curl -w 'response: %{http_code} \n' -X DELETE -H "Content-type: application/json" -d \
 '{
    "tag": ["web", "app"]
  }' \
 http://localhost:4091/entities/client1-localhost-test-1/tags
 ```
**Example 2 - URL params**
```bash
curl -w 'response: %{http_code} \n' -X DELETE \
 "http://localhost:4091/entities/client1-localhost-test-1/tags?tag\[\]=web&tag\[\]=app"
```

**Response** Status: 204 No Content
