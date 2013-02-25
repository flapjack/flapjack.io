
API URLs
========
GET /entities
GET /checks/ENTITY
GET /status/ENTITY[/CHECK]
GET /outages/ENTITY[/CHECK]
GET /unscheduled_maintenances/ENTITY[/CHECK]
<a href="#get_scheduled_maintenances">GET /scheduled_maintenances/ENTITY[/CHECK]</a>
GET /downtime/ENTITY[/CHECK]
POST /scheduled_maintenances/ENTITY/CHECK
POST /acknowledgements/ENTITY/CHECK
POST /test_notifications/ENTITY/CHECK
POST /entities
POST /contacts

```text
GET /entities
GET /checks/ENTITY
GET /status/ENTITY[/CHECK]
GET /outages/ENTITY[/CHECK]
GET /unscheduled_maintenances/ENTITY[/CHECK]
GET /scheduled_maintenances/ENTITY[/CHECK]
GET /downtime/ENTITY[/CHECK]
POST /scheduled_maintenances/ENTITY/CHECK
POST /acknowledgements/ENTITY/CHECK
POST /test_notifications/ENTITY/CHECK
POST /entities
POST /contacts
```

### Query Paramaters

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

### GET /entities
Retrieve an array of all entities, including core attributes of any checks on the entity.

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

### GET /checks/ENTITY
Retrieve the names of the checks for the specified entity.

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

### GET /status/ENTITY[/CHECK]
Get the status of the specified check, or for all checks of the specified entity if no check is given.

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

### GET /outages/ENTITY[/CHECK]

**Optional parameters:** _start_time, end_time_

Get the list of outages for the specified check, or for all checks of the specified entity if no check is given.

**Example 1**
```bash
curl http://localhost:4091/outages/client1-localhost-test-2
```
**Response** Status: 200 OK
```json
[
   {
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
      ],
      "check" : "HOST"
   },
   {
      "outages" : [
         {
            "end_time" : null,
            "summary" : "Connection refused",
            "start_time" : 1355917335,
            "duration" : null,
            "state" : "critical"
         }
      ],
      "check" : "HTTP Port 443"
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

### GET /unscheduled_maintenances/ENTITY[/CHECK]

**Optional parameters:** _start_time, end_time_

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

### GET /downtime/ENTITY[/CHECK]

**Optional parameters:** _start_time, end_time_

Get the list of downtimes for the specified check, or for all checks of the specified entity if no check is given. Downtime is outages minus scheduled maintenances across any given time period. The total seconds of downtime, and the corresponding percentage, are calculated and included in the results.

Note that a start_time and end_time must be specified in order for the percentages to be calculated.

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

### POST /scheduled_maintenances/ENTITY/CHECK'
Creates scheduled maintenance for the specified check.
```ruby
post '/scheduled_maintenances/:entity/:check'
```

### POST /acknowledgements/ENTITY/CHECK'
Acknowledges a problem on the specified check and creates unscheduled maintenance. 4 hrs is the default period but can be specied in the body. An optional message may also be supplied.
```ruby
post '/acknowledgements/:entity/:check'
```

### POST /test_notifications/ENTITY/CHECK
Generates test notifications for the specified check.
```ruby
post '/test_notifications/:entity/:check'
```

### POST /entities
Creates or updates entities from the supplied entities, using id as key.
```ruby
post '/entities'
```

### POST /contacts
Deletes all contacts before importing the supplied contacts.
```ruby
post '/contacts'
```

