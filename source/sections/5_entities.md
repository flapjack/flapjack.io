# Entities

The Entity resource has the following attributes:

Attribute | Type | Description
--- | --- | ---
name | String |
id | String |
tags | Array[String] |
contacts | Array[Contact] |


## Create entities

```shell
curl -w 'response: %{http_code} \n' -X POST -H "Content-type: application/vnd.api+json" -d \
 '{
    "entities": [
      {
        "id": "825",
        "name": "foo.example.com",
        "tags": [
          "foo"
        ]
      }
    ]
  }' \
 http://localhost:3081/entities
```

```ruby
require 'flapjack-diner'
Flapjack::Diner.base_uri('localhost:3081')

Flapjack::Diner.create_entities([
  {
    'id'   => '825',
    'name' => 'foo.example.com',
    'tags' => [ 'foo' ]
  }
])
```

### HTTP Request

`POST /entities`

### Query Parameters

Parameter | Type | Description
--------- | ---- | -----------
entities | Array[Entity] | An array of Entity resources to create.

### HTTP Return Codes

Return code | Description
--------- | -----------
201 | The submitted entities were created successfully.
405 | **Error** The submitted entity data was not sent with the JSONAPI MIME type `application/vnd.api+json`.
409 | **Error** Entities with ids matching those submitted were found.
422 | **Error** The submitted entity data did not conform to the provided specification.


## Get entities

If no entity ids are provided then all entities will be returned; if entity ids
are provided then only the entities matching those ids will be returned.

```shell
curl http://localhost:3081/entities

# or
curl http://localhost:3081/entities/17

# or
curl http://localhost:3081/entities/17,25
```

```ruby
require 'flapjack-diner'
Flapjack::Diner.base_uri('localhost:3081')

Flapjack::Diner.entities

# or
Flapjack::Diner.entities('17')

# or
Flapjack::Diner.entities('17', '25')
```

> The commands return JSON structured like this, which is broken up by Flapjack::Diner into its constituent hashes:

```json
{
  "entities": [
    {
      "id": "301",
      "name": "www.example.com",
      "tags": [
        "production",
      ],
      "links": {
        "contacts": ["5", "87", "123"]
      }
    },
    {
      "id": "302",
      "name": "www.example2.com",
      "tags": [
        "staging"
      ],
      "links": {
        "contacts": []
      }
    }
  ]
}
```

### HTTP Request

`GET /entities`

**or**

`GET /entities/ID[,ID,ID...]`

### Query Parameters

None.

### HTTP Return Codes

Return code | Description
--------- | -----------
200 | OK


## Update entities

Update one or more attributes for one or more entity resources.

```shell
curl -w 'response: %{http_code} \n' -X PATCH -H "Content-Type: application/json-patch+json" -d \
'[
  {"op"    : "replace",
   "path"  : "/entities/0/name",
   "value" : "www.example.com"},
  {"op"    : "add",
   "path"  : "/entities/0/linked/contacts",
   "value" : '352'}
]' \
 'http://localhost:3081/entities/157'
```

```ruby
require 'flapjack-diner'
Flapjack::Diner.base_uri('localhost:3081')

Flapjack::Diner.update_entities(
  [ '157' ],
  :name         => 'www.example_com',
  :add_contacts => [ '352' ]
)
```

### HTTP Request

`PATCH /entities/ID[,ID,ID...]`

### Query Parameters

Parameters sent for entity updates must form a valid [JSON Patch (RFC 6902)](http://tools.ietf.org/html/rfc6902) document. This is comprised of a bare JSON array of JSON-Patch operation objects, which have three members:

Parameter | Type | Description
--------- | ---- | -----------
op | String | one of *replace* (for attributes), *add* or *remove* (for linked objects)
path | String | "/entities/0/ATTRIBUTE" (e.g. 'name') or "/entities/0/links/LINKED_OBJ" (e.g. 'contacts')
value | -> | for attributes, a value of the correct data type for that attribute; for linked objects, the String id of that object

### HTTP Return Codes

Return code | Description
--------- | -----------
204 | The entities were updated successfully.
404 | **Error** No matching entities were found.
405 | **Error** The submitted entity data was not sent with the JSON-Patch MIME type `application/json-patch+json`.
422 | **Error** The submitted entity data did not conform to the provided specification.


## Create scheduled maintenance periods on entities

```shell
curl -w 'response: %{http_code} \n' -X POST -H "Content-type: application/vnd.api+json" -d \
 '{
    "start_time" : "2014-04-09T16:03:25+09:30",
    "duration" : 3600,
    "summary" : "memory replacement"
  }' \
 http://localhost:3081/scheduled_maintenances/entities/825
```

```ruby
require 'flapjack-diner'
Flapjack::Diner.base_uri('localhost:3081')

Flapjack::Diner.create_scheduled_maintenances_entities(
  '825',
  :start_time => '2014-04-09T16:03:25+09:30',
  :duration   => 3600,
  :summary    => 'memory replacement'
)
```

### HTTP Request

`POST /scheduled_maintenances/entities/ID[,ID,ID...]`

### Query Parameters

Parameter | Type | Description
--------- | ---- | -----------
start_time | String | A date &amp; time in ISO 8601 format (YYYY-MM-DDThh:mm:ssZ)
duration | Integer | A length of time (in seconds) that the created scheduled maintenance periods should last.
summary | String | A summary of the reason for the maintenance period.

### HTTP Return Codes

Return code | Description
--------- | -----------
204 | The submitted scheduled maintenance periods were created successfully.
403 | **Error** The required 'start_time' parameter was not sent.
404 | **Error** No matching entities were found.
405 | **Error** The submitted parameters were not sent with the JSONAPI MIME type `application/json`.


## Delete scheduled maintenance periods on entities

```shell
curl -w 'response: %{http_code} \n' -X DELETE \
  'http://localhost:3081/scheduled_maintenances/entities/34?start_time=2014-05-09T16:12:16+09:30'
```

```ruby
require 'flapjack-diner'
Flapjack::Diner.base_uri('localhost:3081')

Flapjack::Diner.delete_scheduled_maintenances_entities(
  34,
  :end_time => '2014-05-09T16:12:16+09:30'
)
```

### HTTP Request

`DELETE /scheduled_maintenances/entities/ID[,ID,ID...]`

### Query Parameters

Parameter | Type | Description
--------- | ---- | -----------
start_time | String | A date &amp; time in ISO 8601 format (YYYY-MM-DDThh:mm:ssZ)

### HTTP Return Codes

Return code | Description
--------- | -----------
204 | Matching scheduled maintenance periods were deleted.
403 | **Error** The required 'start_time' parameter was not sent.
404 | **Error** No matching entities were found.


## Create unscheduled maintenance periods on entities

```shell
curl -w 'response: %{http_code} \n' -X POST -H "Content-type: application/vnd.api+json" -d \
 '{
    "duration" : 3600,
    "summary" : "fixing now"
  }' \
 http://localhost:3081/unscheduled_maintenances/entities/825
```

```ruby
require 'flapjack-diner'
Flapjack::Diner.base_uri('localhost:3081')

Flapjack::Diner.create_unscheduled_maintenances_entities(
  '825',
  :duration => 3600,
  :summary  => 'fixing now'
)
```

### HTTP Request

`POST /unscheduled_maintenances/entities/ID[,ID,ID...]`

### Query Parameters

Parameter | Type | Description
--------- | ---- | -----------
duration | Integer | A length of time (in seconds) that the unscheduled maintenance period(s) should last.
summary | String | A summary of the reason for the creation of the unscheduled maintenance period(s).

### HTTP Return Codes

Return code | Description
--------- | -----------
204 | The submitted unscheduled maintenance periods were created successfully.
404 | **Error** No matching entities were found.
405 | **Error** The submitted parameters were not sent with the JSONAPI MIME type `application/json`.


## Update unscheduled maintenance periods on entities

```shell
curl -w 'response: %{http_code} \n' -X PATCH -H "Content-Type: application/json-patch+json" -d \
'[
  {"op"    : "replace",
   "path"  : "/unscheduled_maintenances/0/end_time",
   "value" : "2014-04-09T16:12:16+09:30"},
]' \
 'http://localhost:3081/unscheduled_maintenances/entities/34'
```

```ruby
require 'flapjack-diner'
Flapjack::Diner.base_uri('localhost:3081')

Flapjack::Diner.update_unscheduled_maintenances_entities(
  '34',
  :end_time => '2014-04-09T16:12:16+09:30'
)
```

### HTTP Request

`PATCH /unscheduled_maintenances/entities/ID[,ID,ID...]`

### Query Parameters

Parameters sent for unscheduled maintenance period updates must form a valid [JSON Patch (RFC 6902)](http://tools.ietf.org/html/rfc6902) document. This is comprised of a bare JSON array of JSON-Patch operation objects, which have three members:

Parameter | Type | Description
--------- | ---- | -----------
op | String | may only be *replace*
path | String | "/unscheduled_maintenances/0/ATTRIBUTE" (e.g. 'end_time')
value | -> | a value of the correct data type for the attribute in the path

### HTTP Return Codes

Return code | Description
--------- | -----------
204 | Matching unscheduled maintenance periods were updated successfully. No content is returned.
404 | Entity resources could not be found for one or more of the provided ids. No unscheduled maintenance periods were altered by this request.
405 | **Error** The submitted data was not sent with the JSON-Patch MIME type `application/json-patch+json`.


## Create test notifications on entities

```shell
curl -w 'response: %{http_code} \n' -X POST -H "Content-type: application/vnd.api+json" -d \
 '{
    "summary" : "testing, testing, 1, 2, 3"
  }' \
 http://localhost:3081/test_notifications/entities/825
```

```ruby
require 'flapjack-diner'
Flapjack::Diner.base_uri('localhost:3081')

Flapjack::Diner.create_test_notifications_entities(
  '825',
  :summary => 'testing, testing, 1, 2, 3'
)
```

### HTTP Request

`POST /test_notifications/entities/ID[,ID,ID...]`

### Query Parameters

Parameter | Type | Description
--------- | ---- | -----------
summary | String | A summary of the reason for the creation of the test notifications.

### HTTP Return Codes

Return code | Description
--------- | -----------
204 | The submitted test notifications were created successfully.
404 | **Error** No matching entities were found.
405 | **Error** The submitted parameters were not sent with the JSONAPI MIME type `application/json`.
