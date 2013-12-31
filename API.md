API URLs
========

Flapjack's HTTP API currently provides the following queries, data import functions and actions:

## Contacts and Notifications

### Contacts

<ul>
  <li><a href="#get_contacts">GET /contacts</a></li>
  <li><a href="#get_contacts_id">GET /contacts/CONTACT_ID</a></li>
  <li><a href="#post_contacts">POST /contacts</a></li>
  <li><a href="#put_contacts_id">PUT, DELETE /contacts/CONTACT_ID</a></li>
  <li><a href="#delete_contacts">DELETE /contacts</a></li>
</ul>

### Media

<ul>
  <li><a href="#get_contacts_id_media">GET /contacts/CONTACT_ID/media</a></li>
  <li><a href="#get_contacts_id_media_media">GET /contacts/CONTACT_ID/media/MEDIA</a></li>
  <li><a href="#put_contacts_id_media_media">PUT, DELETE /contacts/CONTACT_ID/media/MEDIA</a></li>
</ul>

### Notification Rules

<ul>
  <li><a href="#get_contacts_id_notification_rules">GET /contacts/CONTACT_ID/notification_rules</a></li>
  <li><a href="#get_notification_rules_id">GET /notification_rules/RULE_ID</a></li>
  <li><a href="#post_notification_rules">POST /notification_rules</a></li>
  <li><a href="#put_notification_rules_id">PUT, DELETE /notification_rules/RULE_ID</a></li>
</ul>

### Misc

<ul>
  <li><a href="#post_contacts_atomic">POST /contacts_atomic</a></li>
  <li><a href="#get_contacts_id_timezone">GET /contacts/CONTACT_ID/timezone</a></li>
  <li><a href="#put_contacts_id_timezone">PUT, DELETE /contacts/CONTACT_ID/timezone</a></li>
  <li><a href="#get_contacts_id_tags">GET /contacts/CONTACT_ID/tags</a></li>
  <li><a href="#post_contacts_id_tags">POST /contacts/CONTACT_ID/tags</a></li>
  <li><a href="#delete_contacts_id_tags">DELETE /contacts/CONTACT_ID/tags</a></li>
  <li><a href="#get_contacts_id_entitytags">GET /contacts/CONTACT_ID/entity_tags</a></li>
  <li><a href="#post_contacts_id_entitytags">POST /contacts/CONTACT_ID/entity_tags</a></li>
  <li><a href="#delete_contacts_id_entitytags">DELETE /contacts/CONTACT_ID/entity_tags</a></li>
</ul>

## Entities and Checks

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

## Contacts and Notifications

<a id="get_contacts">&nbsp;</a>
### Contacts

#### GET /contacts

Returns all the contacts

**Example**
```bash
curl http://localhost:3081/contacts
```

```json
{
  "contacts": [
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
}
```


<a id="get_contacts_id">&nbsp;</a>
#### GET /contacts/CONTACT_ID

Returns the core information of a specified contact.

**Example**
```bash
curl http://localhost:3081/contacts/21
```

```json
{
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
      "media_intervals": {
        "sms": "3600",
        "email": "7200"
      },
      "media_rollup_thresholds": {
        "sms": "5"
      }
      "tags": [
        "legend",
        "first computer programmer"
      ]
    }
  ]
}
```


<a id="post_contacts">&nbsp;</a>
#### POST /contacts

Creates one or more contacts, returns an array containing the IDs of the created contacts. The ordering is preserved, so if you POST an array of three contacts, the resulting array of IDs will be in the same order as the posted data, so the first item of the POSTed array will correspond to the first ID in the resulting array, etc.

The ID may optionally be supplied. If it is ommitted, then a UUID will be created.

If ID is supplied in any of the included contacts, and any of them clash with an existing contact, the whole request will be rejected and no changes will be written.

**Input JSON Format**
```text
CONTACTS  (array) = [ CONTACT, CONTACT, ...]
CONTACT   (hash)  = { "id": CONTACT_ID, "first_name": FIRST_NAME, "last_name": LAST_NAME,
                      "email": EMAIL, "media": MEDIAS }
MEDIAS    (hash)  = { MEDIA_TYPE: MEDIA, MEDIA_TYPE: MEDIA, "pagerduty": PAGERDUTY... }
MEDIA     (hash)  = { "address": MEDIA_ADDRESS,
                      "interval": INTERVAL,
                      "rollup_threshold": FAILURE_COUNT }
PAGERDUTY (hash)  = { "service_key": PAGERDUTY_SERVICE_KEY, "subdomain": PAGERDUTY_SUBDOMAIN,
                      "username": PAGERDUTY_USERNAME, "password": PAGERDUTY_PASSWORD }
TAGS      (array) = [ "TAG", "TAG", ...]

CONTACT_ID            (string) - a unique, immutable identifier for this contact (optional). If ommitted, a UUID will be created
MEDIA_TYPE            (string) - one of "email", "sms", "jabber", or any other media type we add support for in the future
MEDIA_ADDRESS         (string) - address to send to for the paired MEDIA_TYPE, eg an email address, mobile phone number, or jabber id
PAGERDUTY_SERVICE_KEY (string) - the API key for PagerDuty's integration API, corresponds to a 'service' within this contact's PagerDuty account
PAGERDUTY_SUBDOMAIN   (string) - the subdomain for this contact's PagerDuty account, eg "companyname" in the case of https://companyname.pagerduty.com/
PAGERDUTY_USERNAME    (string) - the username for the PagerDuty REST API (basic http auth) for reading data back out of PagerDuty
PAGERDUTY_PASSWORD    (string) - the password for the PagerDuty REST API
TAG                   (string) - a tag, you know?
INTERVAL              (string) - number of seconds to repeat the same alert on this media type
FAILURE_COUNT         (string) - the number of failing checks this contact has before rollup kicks in, 0 and null mean never
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
        "first_name": "Ada",
        "last_name": "Lovelace",
        "email": "ada@example.com",
        "media": {
          "sms": {
            "address": "+61412345678",
            "interval": "3600",
            "rollup_threshold": "5"
          },
          "email": {
            "address": "ada@example.com",
            "interval": "7200",
            "rollup_threshold": null
          }
        },
        "tags": [
          "legend",
          "first computer programmer"
        ]
      }
    ]
  }' \
 http://localhost:3081/contacts
```
**Response** Status: 200 OK
```json
[
  '4b5897cf-9ba4-4da5-b317-64497e5a49de'
]
```


<a id="put_contacts_id">&nbsp;</a>
#### PUT, DELETE /contacts/CONTACT_ID

Updates, or deletes, a contact.

The data format (for PUT) is the same as the CONTACT hash detailed in <a href="#post_contacts">POST /contacts</a> however ID must not be supplied (as it is present in the URL).

**Example 1 - PUT**
``` bash
curl -w 'response: %{http_code} \n' -X PUT -H "Content-type: application/json" -d \
'{
  "contacts": [
    {
      "first_name": "Ada",
      "last_name": "Lovelace",
      "email": "ada@example.com",
      "media": {
        "sms": {
          "address": "+61412345678",
          "interval": "3600",
          "rollup_threshold": "5"
        },
        "email": {
          "address": "ada@example.com",
          "interval": "7200",
          "rollup_threshold": null
        }
      },
      "tags": [
        "legend",
        "first computer programmer"
      ]
    }
  ]
}' \
 'http://localhost:3081/contacts/21'
```

**Example 2 - DELETE**

``` bash
curl -w 'response: %{http_code} \n' -X DELETE \
  'http://localhost:3081/contacts/21'
```

<a id="delete_contacts">&nbsp;</a>
#### DELETE /contacts?id[]=CONTACT_ID[&id[]=CONTACT_ID[...]]

Deletes multiple contacts.

``` bash
curl -w 'response: %{http_code} \n' -X DELETE \
  'http://localhost:3081/contacts?id[]=21&id[]=22'
```

<a id="get_contacts_id_media">&nbsp;</a>
### Media

#### GET /contacts/CONTACT_ID/media

Returns the media of a contact.

Includes media type, address, interval, and rollup threshold.

**Example**
```bash
curl -w 'response: %{http_code} \n' \
 http://localhost:3081/contacts/21/media
```

<a id="get_contacts_id_media_media">&nbsp;</a>
#### GET /contacts/CONTACT_ID/media/MEDIA

Returns the specified media of a contact.


<a id="put_contacts_id_media_media">&nbsp;</a>
#### PUT, DELETE /contacts/CONTACT_ID/media/MEDIA

Creates or updates (PUT) or deletes (DELETE) a media of a contact

**Example 1 - PUT**
```bash
curl -w 'response: %{http_code} \n' -X PUT -H "Content-type: application/json" -d \
 '{
    "address": "dmitri@example.com",
    "interval": 900,
    "rollup_threshold": 3
  }' \
 http://localhost:3081/contacts/21/media/email
```
**Response** Status: 200 OK
```json
{
  "address": "dmitri@example.com",
  "interval": 900,
  "rollup_threshold": 3
}
```

**Example 2 - DELETE**
```bash
curl -w 'response: %{http_code} \n' -X DELETE \
 http://localhost:3081/contacts/21/media/pagerduty
```
**Response** Status: 204 OK


**Notes:**
* any missing attributes in an update will remove those attributes (eg interval)
* address can't be removed and will cause a validation error

<a id="get_contacts_id_notification_rules">&nbsp;</a>
### Notification Rules

#### GET /contacts/CONTACT_ID/notification_rules

Lists a contact's notification rules.

**Example**
```bash
curl http://localhost:3081/contacts/21/notification_rules
```
**Response** Status: 200 OK
```json
[
  {
    "id": "08f607c7-618d-460a-b3fe-868464eb6045",
    "contact_id": "21",
    "tags": [
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
    "unknown_media": [],
    "warning_media": [
      "email"
    ],
    "critical_media": [
      "sms",
      "email"
    ],
    "unknown_blackhole": false,
    "warning_blackhole": false,
    "critical_blackhole": false
  },
  {
    "id": "2be654d8-9ad4-42b7-963d-f6727dc302a2",
    "contact_id": "21",
    "tags": [
      "database",
      "physical"
    ],
    "entities": [
      "foo-app-02.example.com"
    ],
    "time_restrictions": [],
    "unknown_media": [],
    "warning_media": [
      "email"
    ],
    "critical_media": [
      "sms",
      "email"
    ],
    "unknown_blackhole": false,
    "warning_blackhole": false,
    "critical_blackhole": false
  }
]
```

<a id="get_notification_rules_id">&nbsp;</a>
#### GET /notification_rules/RULE_ID

Returns a specified notification rule.

**Example**
```bash
curl -w 'response: %{http_code} \n' http://localhost:3081/notification_rules/08f607c7-618d-460a-b3fe-868464eb6045
```
**Response** Status: 200 OK
```json
{
  "id": "08f607c7-618d-460a-b3fe-868464eb6045",
  "contact_id": "21",
  "tags": [
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
  "unknown_media": [],
  "warning_media": [
    "email"
  ],
  "critical_media": [
    "sms",
    "email"
  ],
  "unknown_blackhole": false,
  "warning_blackhole": false,
  "critical_blackhole": false
}
```

<a id="post_notification_rules">&nbsp;</a>
#### POST /notification_rules

Creates a new notification rule.

**Example**
```bash
curl -w 'response: %{http_code} \n' -X POST -H "Content-type: application/json" -d \
 '{
    "contact_id": "21",
    "tags": [
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
    "unknown_media": [],
    "warning_media": [
      "email"
    ],
    "critical_media": [
      "sms",
      "email"
    ],
    "unknown_blackhole": false,
    "warning_blackhole": false,
    "critical_blackhole": false
  }' \
 http://localhost:3081/notification_rules
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
#### PUT, DELETE /notification_rules/RULE_ID

Updates or deletes a notification rule

**Example**
```bash
curl -w 'response: %{http_code} \n' -X PUT -H "Content-type: application/json" -d \
 '{
    "tags": [
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
    "unknown_media": [],
    "warning_media": [
      "email"
    ],
    "critical_media": [
      "sms",
      "email"
    ],
    "unknown_blackhole": false,
    "warning_blackhole": false,
    "critical_blackhole": false
  }' \
 http://localhost:3081/notification_rules/08f607c7-618d-460a-b3fe-868464eb6045
```
**Response** Status: 200 OK

Returns the notification rule object as per GET.

**Example 2 - DELETE**
```bash
curl -w 'response: %{http_code} \n' -X DELETE \
 http://localhost:3081/notification_rules/08f607c7-618d-460a-b3fe-868464eb6045
```
**Response** Status: 204 OK

<a id="post_contacts_atomic">&nbsp;</a>
### Misc

#### POST /contacts_atomic

**Deprecated** - use <a href="#post_contacts">POST /contacts</a> instead.

Overwrite all contacts in flapjack. Any existing contacts not found in the supplied JSON payload will be deleted, then newly supplied contacts created, and existing contacts updated.

("atomic" - as in "nuclear").

Uses the same JSON format as <a href="#post_contacts">POST /contacts</a>, however ID is always required.

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
            "interval": "3600",
            "rollup_threshold": "5"
          },
          "email": {
            "address": "ada@example.com",
            "interval": "7200",
            "rollup_threshold": null
          }
        },
        "tags": [
          "legend",
          "first computer programmer"
        ]
      }
    ]
  }' \
 http://localhost:3081/contacts
```
**Response** Status: 204 No Content


<a id="get_contacts_id_timezone">&nbsp;</a>
#### GET /contacts/CONTACT_ID/timezone

Returns the timezone of a contact.

**Example**
```bash
curl -w 'response: %{http_code} \n' http://localhost:3081/contacts/21/timezone
```

**Response** Status: 200 OK
```json
{
  "timezone": "Australia/Broken_Hill"
}
```
FIXME: too much repetition to have the response include the key name "timezone"? Perhaps just return a string?

<a id="put_contacts_id_timezone">&nbsp;</a>
#### PUT, DELETE /contacts/CONTACT_ID/timezone

Sets (PUT) or deletes (DELETE) the timezone of a contact.

**Example**
```bash
curl -w 'response: %{http_code} \n' -X PUT -H "Content-type: application/json" -d \
 '{
    "timezone": "Australia/Broken_Hill"
  }' \
 http://localhost:3081/contacts/21/timezone
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
#### GET /contacts/CONTACT_ID/tags

Gets the tags for a contact.

**Example**
```bash
curl http://localhost:3081/contacts/21/tags
```
**Response** Status: 200 OK
```json
{
  "tags": ["user", "admin"]
}
```

<a name="post_contacts_id_tags">&nbsp;</a>
#### POST /contacts/CONTACT_ID/tags

Add tags to a contact.

**Example 1 - JSON params**
```bash
curl -w 'response: %{http_code} \n' -X POST -H "Content-type: application/json" -d \
 '{
    "tags": ["admin", "user"]
  }' \
 http://localhost:3081/contacts/21/tags
```

**Example 2 - URL params**
```bash
curl -w 'response: %{http_code} \n' -X POST \
 'http://localhost:3081/contacts/21/tags?tags[]=admin&tags[]=user'
```

**Response** Status: 200 OK
```json
{
  "tags": ["user", "admin"]
}
```

<a name="delete_contacts_id_tags">&nbsp;</a>
#### DELETE /contacts/CONTACT_ID/tags

Delete tags from a contact.

**Example 1 - JSON params**
```bash
curl -w 'response: %{http_code} \n' -X DELETE -H "Content-type: application/json" -d \
 '{
    "tags": ["admin", "user"]
  }' \
 http://localhost:3081/contacts/21/tags
 ```
**Example 2 - URL params**
```bash
curl -w 'response: %{http_code} \n' -X DELETE \
 'http://localhost:3081/contacts/21/tags?tags[]=admin&tags[]=user'
```
**Response** Status: 204 No Content

<a name="get_contacts_id_entitytags">&nbsp;</a>
#### GET /contacts/CONTACT_ID/entity_tags

Gets the tags for all entities linked to a contact.

**Example**
```bash
curl http://localhost:3081/contacts/21/entity_tags
```
**Response** Status: 200 OK
```json
{"foo-app-01.example.com" : ["example", "app"],
 "foo-app-02.example.com" : ["example", "database"]}
```

<a name="post_contacts_id_entitytags">&nbsp;</a>
#### POST /contacts/CONTACT_ID/entity_tags

Add tags to entities linked to a contact.

**Example 1 - JSON params**
```bash
curl -w 'response: %{http_code} \n' -X POST -H "Content-type: application/json" -d \
 '{
    "entity": {"foo-app-01.example.com" : ["decommission", "unneeded"],
               "foo-app-02.example.com" : ["upgrade"]}
  }' \
 http://localhost:3081/contacts/21/entity_tags
```
**Example 2 - URL params**
```bash
curl -w 'response: %{http_code} \n' -X POST \
 'http://localhost:3081/contacts/21/entity_tags?entity[foo-app-01.example.com]=decommission&entity[foo-app-01.example.com]=unneeded&entity[foo-app-02.example.com]=upgrade'
```
**Response** Status: 200 OK
```json
{"foo-app-01.example.com" : ["example", "app", "decommission", "unneeded"],
 "foo-app-02.example.com" : ["example", "database", "upgrade"]}
```

<a name="delete_contacts_id_entitytags">&nbsp;</a>
#### DELETE /contacts/CONTACT_ID/entity_tags

Delete tags from entities linked to a contact.

**Example 1 - JSON params**
```bash
curl -w 'response: %{http_code} \n' -X DELETE -H "Content-type: application/json" -d \
 '{
    "entity": {"foo-app-01.example.com" : ["unneeded"],
               "foo-app-02.example.com" : ["upgrade"]}
  }' \
 http://localhost:3081/contacts/21/entity_tags
```
**Example 2 - URL params**
```bash
curl -w 'response: %{http_code} \n' -X DELETE \
 'http://localhost:3081/contacts/21/entity_tags?entity[foo-app-01.example.com]=unneeded&entity[foo-app-02.example.com]=upgrade'
```
**Response** Status: 204 No Content


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


