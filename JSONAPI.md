JSON API
========

This API is moving towards compliance with the [jsonapi specification](http://jsonapi.org/format).

Flapjack's JSON HTTP API currently provides the following queries, data import functions and actions:

## Contacts and Notifications

<ul>
  <li> [Contacts](jsonapi-contacts) </li>
  <li> [Media](jsonapi-media) </li>
  <li> [Notification Rules](jsonapi-notification_rules) </li>
  <li> [Miscellaneous](jsonapi-miscellaneous) </li>
</ul>
 
### Entities
<ul>
  <li><a href="#get_entities">GET /entities</a></li>
  <li><a href="#post_entities">POST /entities</a></li>
  <li><a href="#get_entities_id_tags">GET /entities/ENTITY/tags</a></li>
  <li><a href="#post_entities_id_tags">POST /entities/ENTITY/tags</a></li>
  <li><a href="#delete_entities_id_tags">DELETE /entities/ENTITY/tags</a></li>
</ul>
</ul>

### Checks

<ul>
  <li><a href="#get_checks">GET /checks/ENTITY</a></li>
</ul>

### Status, Maintenances, Acknowledgements, Outages

<ul>
  <li><a href="#get_status">GET /status[/ENTITY[/CHECK]]</a></li>
  <li><a href="#get_outages">GET /outages[/ENTITY[/CHECK]]</a></li>
  <li><a href="#get_unscheduled_maintenances">GET /unscheduled_maintenances[/ENTITY[/CHECK]]</a></li>
  <li><a href="#post_acknowledgements">POST /acknowledgements/ENTITY/CHECK</a></li>
  <li><a href="#delete_unscheduled_maintenances">DELETE /unscheduled_maintenances[/ENTITY[/CHECK]]</a></li>
  <li><a href="#get_scheduled_maintenances">GET /scheduled_maintenances[/ENTITY[/CHECK]]</a></li>
  <li><a href="#post_scheduled_maintenances">POST /scheduled_maintenances[/ENTITY[/CHECK]]</a></li>
  <li><a href="#delete_scheduled_maintenances">DELETE /scheduled_maintenances[/ENTITY[/CHECK]]</a></li>
  <li><a href="#get_downtime">GET /downtime[/ENTITY[/CHECK]]</a></li>
</ul>

### Test Notifications

<ul>
  <li><a href="#post_test_notifications">POST /test_notifications[/ENTITY[/CHECK]]</a></li>
</ul>


See also the [flapjack-diner](https://github.com/flpjck/flapjack-diner/) gem which provides a ruby consumer of this API.

## Query Paramaters

Some of the GET queries can take some optional query string parameters as follows:

<table>
  <tr>
    <th>parameter</th>
    <th>description</th>
  </tr>
  <tr>
    <td>start_time</td>
    <td>start time of the period in ISO 8601 format, eg 2013-02-22T15:39:39+11:00. Absence means 'beginning of time'.</td>
  </tr>
  <tr>
    <td>end_time</td>
    <td>end time of the period in ISO 8601 format. Absence means 'end of days'.</td>
  </tr>
</table>

These five GET queries:

<ul>
  <li><a href="#get_status">GET /status[/ENTITY[/CHECK]]</a></li>
  <li><a href="#get_outages">GET /outages[/ENTITY[/CHECK]]</a></li>
  <li><a href="#get_unscheduled_maintenances">GET /unscheduled_maintenances[/ENTITY[/CHECK]]</a></li>
  <li><a href="#get_scheduled_maintenances">GET /scheduled_maintenances[/ENTITY[/CHECK]]</a></li>
  <li><a href="#get_downtime">GET /downtime[/ENTITY[/CHECK]]</a></li>
</ul>

take ENTITY and CHECK strings as part of the URL for backwards compatibility; they
also offer a more flexible parameter scheme by which the data for multiple entities
and checks can be requested.

<table>
  <tr>
    <th>parameter</th>
    <th>description</th>
  </tr>
  <tr>
    <td>entity / entity[]</td>
    <td>Request the data for all the checks from one entity (e.g. ``/status?entity=ENTITY``) or from multiple entities (e.g. ``/status?entity[]=ENTITY1&entity[]=ENTITY2``)</td>
  </tr>
  <tr>
    <td>check[ENTITY]</td>
    <td>Request the data for a single check from an entity (e.g. ``/status?check[ENTITY]=CHECK``), multiple checks from a single entity (e.g. ``/status?check[ENTITY]=CHECK1&check[ENTITY]=CHECK2``), or multiple checks from different entities (e.g. ``/status?check[ENTITY1]=CHECK1&check[ENTITY2]=CHECK2``).
      <br>
      <br>
      Also note that this can be combined with the entity parameters: ``/status?entity=ENTITY1&check[ENTITY2]=CHECK`` is a valid query.
    </td>
  </tr>
</table>

The corresponding POST/DELETE methods take a similar parameter set, but the
data is expressed as encoded form parameters, or serialized as JSON, etc.

---










## Entities and Checks

<a id="get_entities">&nbsp;</a>
### Entities

#### GET /entities
Retrieve an array of all entities including core attributes and state of any checks on the entity.

**Output JSON Format**
```text
ENTITIES (array) = [ENTITY, ENTITY, ...]
ENTITY    (hash) = { "id": "ENTITY_ID", "name": "NAME", "checks": CHECKS }
CHECKS   (array) = [ CHECK, CHECK, ... ]
CHECK     (hash) = { "check": "CHECK_NAME",
                     "entity": "ENTITY_NAME",
                     "status": STATUS }
STATUS    (hash) = { "name": "CHECK_NAME",
                     "state": "CHECK_STATE",
                     "enabled": BOOLEAN,
                     "summary": STRING,
                     "details": STRING or NULL,
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
curl http://localhost:3081/entities
```
**Response** Status: 200 OK
```json
[
   {
      "checks" : [
         {
            "entity" : "foo-app-02.example.com",
            "check" : "HOST",
            "status" : {
              "name" : "HOST",
              "state" : "ok",
              "enabled" : true,
              "summary" : "OK",
              "details" : null,
              "in_scheduled_maintenance" : false,
              "in_unscheduled_maintenance" : false,
              "last_update" : 1356853261,
              "last_problem_notification" : null,
              "last_recovery_notification" : null,
              "last_acknowledgement_notification" : null,
           }
         }
      ],
      "name" : "foo-app-02.example.com",
      "id" : "10002"
   }
]
```

<a id="post_entities">&nbsp;</a>
#### POST /entities

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
 http://localhost:3081/entities
```
**Response** Status: 204 No Content


<a name="get_entities_id_tags">&nbsp;</a>
#### GET /entities/ENTITY/tags

Gets the tags for an entity.

**Example**
```bash
curl http://localhost:3081/entities/foo-app-01.example.com/tags
```
**Response** Status: 200 OK
```json
["web", "app"]
```

<a name="post_entities_id_tags">&nbsp;</a>
#### POST /entities/ENTITY/tags

Add tags to an entity.

**Example 1 - JSON params**
```bash
curl -w 'response: %{http_code} \n' -X POST -H "Content-type: application/json" -d \
 '{
    "tag": ["web", "app"]
  }' \
 http://localhost:3081/entities/foo-app-01.example.com/tags
 ```
**Example 2 - URL params**
```bash
curl -w 'response: %{http_code} \n' -X POST \
 'http://localhost:3081/entities/foo-app-01.example.com/tags?tag[]=web&tag[]=app'
```
**Response** Status: 200 OK
```json
["web", "app"]
```

Add tags to an entity.

<a name="delete_entities_id_tags">&nbsp;</a>
#### DELETE /entities/ENTITY/tags

Delete tags from an entity.

**Example 1 - JSON params**
```bash
curl -w 'response: %{http_code} \n' -X DELETE -H "Content-type: application/json" -d \
 '{
    "tag": ["web", "app"]
  }' \
 http://localhost:3081/entities/foo-app-01.example.com/tags
 ```
**Example 2 - URL params**
```bash
curl -w 'response: %{http_code} \n' -X DELETE \
 'http://localhost:3081/entities/foo-app-01.example.com/tags?tag[]=web&tag[]=app'
```

**Response** Status: 204 No Content


<a id="get_checks">&nbsp;</a>
### Checks

#### GET /checks/ENTITY
Retrieve the names of the checks for the specified entity.

**Output JSON Format**
```text
CHECKS   (array) = [ CHECK_NAME, CHECK_NAME, ... ]
```

**Example**
```bash
curl http://localhost:3081/checks/foo-app-02.example.com
```
**Response** Status: 200 OK
```json
[
   "HOST",
   "HTTP Port 443"
]
```

<a id="get_status">&nbsp;</a>
### Status, Maintenances, Acknowledgements, Outages

#### GET /status[/ENTITY[/CHECK]]
Get the status of a specified check, or for all checks of a specified entity, or for checks on multiple entities.

**Output JSON Format**
```text
CHECKS   (array) = [ CHECK, CHECK, ... ]
CHECK     (hash) = { "name": "CHECK_NAME",
                     "state": "CHECK_STATE",
                     "summary": "SUMMARY",
                     "details": "DETAILS",
                     "in_unscheduled_maintenance": BOOLEAN,
                     "in_scheduled_maintenance": BOOLEAN,
                     "last_update": TIMESTAMP,
                     "last_problem_notification": TIMESTAMP,
                     "last_recovery_notification": TIMESTAMP,
                     "last_acknowledgement_notification": TIMESTAMP }

TIMESTAMP: unix timestamp (number of seconds since 1 January 1970, UTC)
BOOLEAN:   one of 'true' or 'false'

NB: a bulk query wraps each returned array item with entity & check details (see example 3).
```

**Example 1**
```bash
curl http://localhost:3081/status/foo-app-02.example.com
```
**Response** Status: 200 OK
```json
[
   {
      "last_recovery_notification" : null,
      "last_acknowledgement_notification" : null,
      "last_update" : 1356853261,
      "name" : "HOST",
      "summary": "available",
      "details": null,
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
      "summary": "unavailable",
      "details": null,
      "last_problem_notification" : 1356853151,
      "in_scheduled_maintenance" : false,
      "in_unscheduled_maintenance" : false,
      "state" : "critical"
   }
]
```

**Example 2**
```bash
curl http://localhost:3081/status/foo-app-02.example.com/HTTP+Port+443
```
**Response** Status: 200 OK
```json
 {
    "last_recovery_notification" : null,
    "last_acknowledgement_notification" : null,
    "last_update" : 1356853261,
    "name" : "HTTP Port 443",
    "summary": "timed out",
    "details": null,
    "last_problem_notification" : 1356853151,
    "in_scheduled_maintenance" : false,
    "in_unscheduled_maintenance" : false,
    "state" : "critical"
 }
```

**Example 3**
```bash
curl http://localhost:3081/status?check[foo-app-02.example.com]=HOST&check[foo-app-02.example.com]=HTTP+Port+443
```
**Response** Status: 200 OK
```json
[
  {
    "entity" : "foo-app-02.example.com",
    "check" : "HOST",
    "status" :
    {
      "last_recovery_notification" : null,
      "last_acknowledgement_notification" : null,
      "last_update" : 1356853261,
      "name" : "HOST",
      "last_problem_notification" : null,
      "in_scheduled_maintenance" : false,
      "in_unscheduled_maintenance" : false,
      "state" : "ok",
      "summary" : "host is up",
      "details" : null,
      "enabled" : true
    }
  },
  {
    "entity" : "foo-app-02.example.com",
    "check" : "HTTP Port 443",
    "status" :
    {
      "last_recovery_notification" : null,
      "last_acknowledgement_notification" : null,
      "last_update" : 1356853261,
      "name" : "HTTP Port 443",
      "last_problem_notification" : 1356853151,
      "in_scheduled_maintenance" : false,
      "in_unscheduled_maintenance" : false,
      "state" : "critical",
      "summary" : "Connection Refused",
      "details" : null,
      "enabled" : true
    }
  }
]
```

<a id="get_outages">&nbsp;</a>
#### GET /outages[/ENTITY[/CHECK]]

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

NB: a bulk query adds entity names to the CHECK hash (see example 3).
```

Get the list of outages for a check, or for all checks of an entity, or for checks on multiple entities.

**Example 1**
```bash
curl http://localhost:3081/outages/foo-app-02.example.com
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
curl http://localhost:3081/outages/foo-app-02.example.com/HOST?start_time=2012-12-24T00:00:00Z
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

**Example 3**
```bash
curl http://localhost:3081/outages?entity=foo-app-01.example.com&check[foo-app-02.example.com]=HTTP+Port+443
```
**Response** Status: 200 OK
```json
[
   {
      "entity" : "foo-app-01.example.com",
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
      "entity" : "foo-app-02.example.com",
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

<a id="get_unscheduled_maintenances">&nbsp;</a>
#### GET /unscheduled_maintenances[/ENTITY[/CHECK]]

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

NB: a bulk query adds entity names to the CHECK hash (see example 2).
```

Get the list of unscheduled maintenance periods for a check, or for all checks of an entity, or for checks on multiple entities.

**Example 1**
```bash
curl http://localhost:3081/unscheduled_maintenances/foo-app-01.example.com
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

**Example 2**
```bash
curl http://localhost:3081/unscheduled_maintenances?entity[]=foo-app-01.example.com&entity[]=foo-app-02.example.com
```
**Response** Status: 200 OK
```json
[
   {
      "entity" : "foo-app-01.example.com",
      "check" : "HOST",
      "unscheduled_maintenance" : []
   },
   {
      "entity" : "foo-app-01.example.com",
      "check" : "HTTP Port 443",
      "unscheduled_maintenance" : [
         {
            "end_time" : 1356067056,
            "summary" : "- JR looking",
            "start_time" : 1356044450,
            "duration" : 22606
         }
      ]
   },
   {
      "entity" : "foo-app-02.example.com",
      "check" : "HOST",
      "unscheduled_maintenance" : []
   },
   {
      "entity" : "foo-app-02.example.com",
      "check" : "HTTP Port 443",
      "unscheduled_maintenance" : []
   }
]
```

<a id="post_acknowledgements">&nbsp;</a>
#### POST /acknowledgements[/ENTITY[/CHECK]]'
Acknowledges a problem on a check (or for all checks of an entity, or for checks on multiple entities) and creates unscheduled maintenance. 4 hrs is the default period but can be specified in the body. An optional message may also be supplied.

**Input JSON Format**
```text
ACK (hash) = { "duration": DURATION,
               "summary": "SUMMARY" }

(BULK is merged into the above hash if the entity and check are not provided
in the request URL.)

BULK          (hash) = { "entity" : ENTITIES,
                         "check" : ENTITY_CHECKS }
ENTITY      (string) = entity name
ENTITIES    (string) = ENTITY or
            (array)    [ENTITY, ...]
ENTITY_CHECKS (hash) = { ENTITY : CHECKS, ... }
CHECK       (string) = check name
CHECKS      (string) = CHECK or
             (array)   [CHECK, ...]
```

**Example 1**
```bash
curl -w 'response: %{http_code} \n' -X POST -H "Content-type: application/json" -d \
 '{
    "duration": 3600,
    "summary": "AL - working on it"
  }' \
 http://localhost:3081/acknowledgements/foo-app-02.example.com/HOST
```
**Response** Status: 204 (No Content)

**Example 2**
```bash
curl -w 'response: %{http_code} \n' -X POST -H "Content-type: application/json" -d \
 '{
    "check" : {
      "foo-app-02.example.com" : ["ping", "ssh"]
    },
    "duration": 3600,
    "summary": "AL - working on it"
  }' \
 http://localhost:3081/acknowledgements
```
**Response** Status: 204 (No Content)


<a id="delete_unscheduled_maintenances">&nbsp;</a>
#### DELETE /unscheduled_maintenances[/ENTITY[/CHECK]]
Deletes an unscheduled maintenance period on a check (or for all checks of an entity, or for checks on multiple entities). An optional end time may be supplied -- the deletion will take effect immediately if it is not.

**Input JSON Format**
```text
UNSCHED_MAINT (hash) = { "end_time": TIME }

(BULK is merged into the above hash if the entity and check are not provided
in the request URL.)

BULK          (hash) = { "entity" : ENTITIES,
                         "check" : ENTITY_CHECKS }
ENTITY      (string) = entity name
ENTITIES    (string) = ENTITY or
            (array)    [ENTITY, ...]
ENTITY_CHECKS (hash) = { ENTITY : CHECKS, ... }
CHECK       (string) = check name
CHECKS      (string) = CHECK or
             (array)   [CHECK, ...]
```

**Example 1**
```bash
curl -w 'response: %{http_code} \n' -X DELETE -H "Content-type: application/json" \
 http://localhost:3081/unscheduled_maintenances/foo-app-02.example.com/HOST
```
**Response** Status: 204 (No Content)

**Example 2**
```bash
curl -w 'response: %{http_code} \n' -X DELETE -H "Content-type: application/json" -d \
 '{
    "check" : {
      "foo-app-02.example.com" : ["ping", "ssh"]
    },
    "end_time" : "2012-12-21T15:47:36+10:30",
  }' \
 http://localhost:3081/unscheduled_maintenances
```
**Response** Status: 204 (No Content)


<a id="get_scheduled_maintenances">&nbsp;</a>
#### GET /scheduled_maintenances[/ENTITY[/CHECK]]

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

NB: a bulk query adds entity names to the CHECK hash (see example 2).
```

Get the list of scheduled maintenance periods for a check (or for all checks of an entity, or for checks on multiple entities).

**Example 1**
```bash
curl http://localhost:3081/scheduled_maintenances/foo-app-02.example.com
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

**Example 2**
```bash
curl http://localhost:3081/scheduled_maintenances?check[foo-app-02.example.com]=HOST
```
**Response** Status: 200 OK
```json
[
   {
      "entity" : "foo-app-02.example.com",
      "check" : "HOST",
      "scheduled_maintenance" : []
   }
]
```

<a id="post_scheduled_maintenances">&nbsp;</a>
#### POST /scheduled_maintenances[/ENTITY/CHECK]'
Creates scheduled maintenance for the specified check.

**Input JSON Format**
```text
MAINT (hash) = { "start_time": TIME,
                 "duration": DURATION,
                 "summary": "SUMMARY" }

(BULK is merged into the above hash if the entity and check are not provided
in the request URL.)

BULK          (hash) = { "entity" : ENTITIES,
                         "check" : ENTITY_CHECKS }
ENTITY      (string) = entity name
ENTITIES    (string) = ENTITY or
            (array)    [ENTITY, ...]
ENTITY_CHECKS (hash) = { ENTITY : CHECKS, ... }
CHECK       (string) = check name
CHECKS      (string) = CHECK or
             (array)   [CHECK, ...]
```

**Example 1**
```bash
curl -w 'response: %{http_code} \n' -X POST -H "Content-type: application/json" -d \
 '{
    "start_time": "2012-12-21T15:47:36+10:30",
    "duration": 3600,
    "summary": "SHUT IT ALL DOWN!"
  }' \
 http://localhost:3081/scheduled_maintenances/foo-app-02.example.com/HOST
```
**Response** Status: 204 (No Content)

**Example 2**
```bash
curl -w 'response: %{http_code} \n' -X POST -H "Content-type: application/json" -d \
 '{
    "entity" : "foo-app-01.example.com",
    "check" : {
      "foo-app-02.example.com" : "HOST"
    },
    "start_time": "2012-12-21T15:47:36+10:30",
    "duration": 3600,
    "summary": "SHUT IT ALL DOWN!"
  }' \
 http://localhost:3081/scheduled_maintenances
```
**Response** Status: 204 (No Content)


<a id="delete_scheduled_maintenances">&nbsp;</a>
#### DELETE /scheduled_maintenances[/ENTITY[/CHECK]]'
Deletes an scheduled maintenance period on a check (or for all checks of an entity, or for checks on multiple entities). An optional end time may be supplied -- the deletion will take effect immediately if it is not.

**Input JSON Format**
```text
SCHED_MAINT (hash) = { "end_time": TIME }

(BULK is merged into the above hash if the entity and check are not provided
in the request URL.)

BULK          (hash) = { "entity" : ENTITIES,
                         "check" : ENTITY_CHECKS }
ENTITY      (string) = entity name
ENTITIES    (string) = ENTITY or
            (array)    [ENTITY, ...]
ENTITY_CHECKS (hash) = { ENTITY : CHECKS, ... }
CHECK       (string) = check name
CHECKS      (string) = CHECK or
             (array)   [CHECK, ...]
```

**Example 1**
```bash
curl -w 'response: %{http_code} \n' -X DELETE -H "Content-type: application/json" \
 http://localhost:3081/scheduled_maintenances/foo-app-02.example.com/HOST
```
**Response** Status: 204 (No Content)

**Example 2**
```bash
curl -w 'response: %{http_code} \n' -X DELETE -H "Content-type: application/json" -d \
 '{
    "check" : {
      "foo-app-02.example.com" : ["ping", "ssh"]
    },
    "end_time" : "2012-12-21T15:47:36+10:30",
  }' \
 http://localhost:3081/scheduled_maintenances
```
**Response** Status: 204 (No Content)


<a id="get_downtime">&nbsp;</a>
#### GET /downtime[/ENTITY[/CHECK]]

**Optional parameters:** _start_time, end_time_

Get the list of downtimes for a check (or for all checks of an entity, or for checks on multiple entities). Downtime is outages minus scheduled maintenances across any given time period (See [the glossary](GLOSSARY)). The total seconds of downtime, and the corresponding percentage, are calculated and included in the results.

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

NB: a bulk query adds entity names to the CHECK hash (see example 2).
```

**Notes:**
* the states under PERCENTAGES and TOTAL_SECONDS may be omitted if they are zero.
* the non-ok states under PERCENTAGES and TOTAL_SECONDS represent total downtime for this state.
* the ok state time is calculated as: total report period - sum of non OK downtime durations

**Example 1**
```bash
curl "http://localhost:3081/downtime/foo-app-02.example.com/HOST?start_time=2012-12-01T00:00:00Z&end_time=2013-01-01T00:00:00Z"
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

**Example 2**
```bash
curl "http://localhost:3081/downtime?check[foo-app-02.example.com]=HOST&start_time=2012-12-01T00:00:00Z&end_time=2013-01-01T00:00:00Z"
```
**Response** Status: 200 OK
(See the Response section for the previous example.)


<a id="post_test_notifications">&nbsp;</a>
### Test Notifications

#### POST /test_notifications[/ENTITY/CHECK]
Generates test notifications for the specified check. Body can be left empty.

**Input JSON Format**
```text
(BULK is only used if the entity and check are not provided in the request URL.)

BULK          (hash) = { "entity" : ENTITIES,
                         "check" : ENTITY_CHECKS }
ENTITY      (string) = entity name
ENTITIES    (string) = ENTITY or
            (array)    [ENTITY, ...]
ENTITY_CHECKS (hash) = { ENTITY : CHECKS, ... }
CHECK       (string) = check name
CHECKS      (string) = CHECK or
             (array)   [CHECK, ...]
```

**Example 1**
```bash
curl -X POST "http://localhost:3081/test_notifications/foo-app-01.example.com/HOST"
```

**Example 2**
```bash
curl -w 'response: %{http_code} \n' -X POST -H "Content-type: application/json" -d \
 '{
    "entity": "foo-app-02.example.com"
  }' \
 http://localhost:3081/test_notifications
```

**Response** Status: 204 No Content


