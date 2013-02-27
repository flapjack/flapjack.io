
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
NAME          (string) - name of the entity, eg a hostname / service identifier. syntax rules for unqualified hostnames applies to this field (eg only alphanumeric, mustn't start with a number etc) TODO: actually, perhaps this needs to allow FQDNs? Essentially it needs to match up with whatever is put into the nagios check config.
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

## Warning: Vapourware Follows!

The following API interactions are in the design phase and are likely to change before and/or during implementation.

### GET /contacts/CONTACT_ID/notification_rules

Lists the IDs of this contact's notification rules.

**Example**
```bash
curl http://localhost:4091/contacts/23/notification_rules
```
**Response** Status: 200 OK
```json
[
  "j4xh6jfh"
]
```

### GET /contacts/CONTACT_ID/notification_rules/RULE_ID

Get the specified notification rule for this user

**Example**
```bash
curl -w 'response: %{http_code} \n' http://localhost:4091/contacts/23/notification_rules/1
```
**Response** Status: 200 OK
```json
{
  "rule_id": "1",
  "entity_tags": [
    "database",
    "physical"
  ],
  "entities": [
    "foo-app-01.example.com"
  ],
  "time_restrictions": [
    {
      "TODO": "TODO"
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

### POST /contacts/CONTACT_ID/notification_rules

Create a new notification rule for the specified contact.

**Example**
```bash
curl -w 'response: %{http_code} \n' -X POST -H "Content-type: application/json" -d \
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
        "TODO": "TODO"
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
 http://localhost:4091/contacts/23/notification_rules
```
**Response** Status: 200 OK

Returns the notification rule object as per GET.

**Notes:**
* if rule_id is not supplied then one will be generated by flapjack and supplied in the response body along with the rest of the contact's information


### PUT, DELETE /contacts/CONTACT_ID/notification_rules/RULE_ID

Create or update (PUT) or delete (DELETE) a contact's notification rule

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
        "TODO": "TODO"
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
 http://localhost:4091/contacts/23/notification_rules/1
```
**Response** Status: 200 OK

Returns the notification rule object as per GET.

**Example 2 - DELETE**
```bash
curl -w 'response: %{http_code} \n' -X DELETE \
 http://localhost:4091/contacts/23/notification_rules/1
```
**Response** Status: 204 OK

**Notes:**
* if rule_id is not supplied then one will be generated by flapjack and supplied in the response body (possibly along with the whole notification_rule object?)



### GET /contacts

Returns a list of all contacts

### GET /contacts/CONTACT_ID

Returns the core information about the specified contact.

### GET /contacts/CONTACT_ID/media

Returns a list of media (addresses, intervals) of the specified contact.

**Example**
```bash
curl -w 'response: %{http_code} \n' \
 http://localhost:4091/contacts/23/media
```



### GET /contacts/CONTACT_ID/media/MEDIA

Retrieve the specified media of the contact.


### PUT, DELETE /contacts/CONTACT_ID/media/MEDIA

Create or update (PUT) or delete (DELETE) a contact media for the contact

**Example 1 - PUT**
```bash
curl -w 'response: %{http_code} \n' -X PUT -H "Content-type: application/json" -d \
 '{
    "address": "dmitri@example.com",
    "interval": 900
  }' \
 http://localhost:4091/contacts/23/media/email
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
 http://localhost:4091/contacts/23/media/pagerduty
```
**Response** Status: 204 OK


**Notes:**
* any missing attributes in an update will remove those attributes (eg interval)
* address can't be removed and will cause a validation error

### GET /contacts/CONTACT_ID/timezone

Returns the timezone string for the contact.

**Example**
```text
curl -w 'response: %{http_code} \n' http://localhost:4091/contacts/23/timezone
```

**Response** Status: 200 OK
```json
{
  "timezone": "Australia/Broken_Hill"
}
```
FIXME: too much repetition to have the response include the key name "timezone"? Perhaps just return a string?

### PUT, DELETE /contacts/CONTACT_ID/timezone

Sets (PUT) or deletes (DELETE) the timezone string for the contact.

**Example**
```text
curl -w 'response: %{http_code} \n' -X PUT -H "Content-type: application/json" -d \
 '{
    "timezone": "Australia/Broken_Hill"
  }' \
 http://localhost:4091/contacts/23/timezone
```

**Response** Status: 200 OK
```json
{
  "timezone": "Australia/Broken_Hill"
}
```

**Notes:**
* the timezone string must be one defined in the tzinfo database, see: http://www.twinsun.com/tz/tz-link.htm, http://tzinfo.rubyforge.org/doc/

