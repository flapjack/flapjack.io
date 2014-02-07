# [JSON API](jsonapi) :: Entities

* [GET /entities](#get_entities)
* [POST /entities](#post_entities)

<a id="get_entities">&nbsp;</a>
### GET /entities
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
 http://localhost:3081/entities
```
**Response** Status: 204 No Content
