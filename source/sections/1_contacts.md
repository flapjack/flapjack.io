
# Contacts

The Contact resource has the following attributes:

Attribute | Type | Description
--- | --- | ---
id | String |
first_name | String |
last_name | String |
email | String |
media | Hash[Medium] |
notification_rules | Array[NotificationRule]
timezone | String |
tags | Array[String] |

## Create contacts

Creates one or more contacts, returns an array containing the ids of the created contacts. The ordering is preserved, so if you POST an array of three contacts, the resulting array of ids will be in the same order as the posted data; the first item of the POSTed array will correspond to the first id in the resulting array, etc.

Contact ids may optionally be supplied. If it is omitted, then a UUID will be created.

If an id is supplied in any of the included contacts, and any of them clash with an existing contact, the whole request will be rejected and no changes will be written.

```shell
curl -w 'response: %{http_code} \n' -X POST -H "Content-Type: application/vnd.api+json" -d \
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
        "timezone": "Europe/London",
        "tags": [
          "legend",
          "first computer programmer"
        ]
      }
    ]
  }' \
 http://localhost:3081/contacts
```

```ruby
require 'flapjack-diner'
Flapjack::Diner.base_uri('localhost:3081')

Flapjack::Diner.create_contacts({"first_name" => "Ada",
                                  "last_name"  => "Lovelace",
                                  "email"      => "ada@example.com"})
```

> The above command returns JSON structured like this:

```json
["cd40283b-023e-43e2-a79c-1910415afdc2"]
```

### HTTP Request

    POST http://localhost:3081/contacts<br>
    Content-Type: application/vnd.api+json<br>
    Accept: application/vnd.api+json

### Query Parameters

Parameter | Type | Description
--------- | ---- | -----------
contacts | Array[Contact] | An array of Contact resources to create.

### HTTP Return Codes

Return code | Description
--------- | -----------
201 | The submitted contacts were created successfully.
405 | **Error** The submitted contact data was not sent with the JSONAPI MIME type `application/vnd.api+json`.
409 | **Error** Contacts with ids matching those submitted were found.
422 | **Error** The submitted contact data did not conform to the provided specification.


## Get contacts

If no contact ids are provided then all contacts will be returned; if contact ids
are provided then only the contacts matching those ids will be returned.

TODO add link ids, URLs for media, notification rules

```shell
curl http://localhost:3081/contacts
# or
curl http://localhost:3081/contacts/1
# or
curl http://localhost:3081/contacts/21,22
```

```ruby
require 'flapjack-diner'
Flapjack::Diner.base_uri('localhost:3081')

Flapjack::Diner.contacts
# or
Flapjack::Diner.contacts('21')
# or
Flapjack::Diner.contacts('21', '22')
```

> The above commands returns JSON structured like this:

```json
{
  "contacts": [
    {
      "id": "21",
      "first_name": "Ada",
      "last_name": "Lovelace",
      "email": "ada@example.com",
      "timezone": "Europe/London",
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
      "timezone": "UTC",
      "tags": [
        "grump"
      ]
    }
  ]
}
```

### HTTP Request

    GET http://localhost:3081/contacts<br>
    Accept: application/vnd.api+json

**or**

    GET http://localhost:3081/contacts/ID[,ID,ID...]<br>
    Accept: application/vnd.api+json

### Query Parameters

None.

### HTTP Return Codes

Return code | Description
--------- | -----------
200 | OK


## Update contacts

Update one or more attributes for one or more contact resources.

```shell
curl -w 'response: %{http_code} \n' -X PATCH -H "Content-Type: application/vnd.api+json" -d \
'[
  {"op"    : "replace",
   "path"  : "/contacts/0/first_name",
   "value" : "John"},
  {"op"    : "replace",
   "path"  : "/contacts/0/last_name",
   "value" : 'Smith'}
]' \
 'http://localhost:3081/contacts/23'
```

```ruby
require 'flapjack-diner'
Flapjack::Diner.base_uri('localhost:3081')

Flapjack::Diner.update_contacts(23, :first_name => 'John', :last_name => 'Smith')
```

### HTTP Request

    PATCH http://localhost:3081/contacts/ID[,ID,ID...]<br>
    Content-Type: application/vnd.api+json<br>
    Accept: application/vnd.api+json

### Query Parameters

Parameters sent for contact updates must form a valid [JSON Patch (RFC 6902)](http://tools.ietf.org/html/rfc6902) document. This is comprised of a bare JSON array of JSON-Patch operation objects, which have three members:

Parameter | Type | Description
--------- | ---- | -----------
op | String | one of *replace* (for attributes), *add* or *remove* (for linked objects)
path | String | "/contacts/0/ATTRIBUTE" (e.g. 'first_name') or "/contacts/0/links/LINKED_OBJ" (e.g. 'media')
value | -> | for attributes, a value of the correct data type for that attribute; for linked objects, the String id of that object

### HTTP Return Codes

TODO


## Delete contacts

Delete one or more contacts.

```shell
curl -w 'response: %{http_code} \n' -X DELETE \
  'http://localhost:3081/contacts/21'
# or
curl -w 'response: %{http_code} \n' -X DELETE \
  'http://localhost:3081/contacts/21,22'
```

```ruby
require 'flapjack-diner'
Flapjack::Diner.base_uri('localhost:3081')

Flapjack::Diner.delete_contacts('21')
# or
Flapjack::Diner.delete_contacts('21', '22')
```

### HTTP Request

    DELETE http://localhost:3081/contacts/ID[,ID,ID...]

### Query Parameters

None.

### HTTP Return Codes

Return code | Description
--------- | -----------
204 | Contact(s) were deleted
404 | Contacts could not be found for one or more of the provided ids. No contacts were deleted by this request.
