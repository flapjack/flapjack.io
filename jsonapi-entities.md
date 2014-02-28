# [JSON API](jsonapi) :: Entities

* [GET /entities](#get_entities)
* [POST /entities](#post_entities)

<a id="get_entities">&nbsp;</a>
### GET /entities
Retrieve all entities and any linked contacts.

**Example**
```bash
curl http://localhost:3081/entities
```
**Response** Status: 200 OK
```json
{
  "entities": [
    {
      "id": "1234",
      "name": "foo-app-02.example.com",
    },
    {
      "id": "1235",
      "name": "foo-app-02.example.com",
    }
  ]
}
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
