# Entities

The Entity resource has the following attributes:

Attribute | Type | Description
--- | --- | ---
name | String |
id | String |
contacts | Array[Contact] |


## Create entities

```shell
```

```ruby
require 'flapjack-diner'
Flapjack::Diner.base_uri('localhost:3081')

```

### HTTP Request

    POST http://localhost:3081/entities<br>
    Content-Type: application/vnd.api+json<br>
    Accept: application/vnd.api+json

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
curl http://localhost:3081/enities/17
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

### HTTP Request

    GET http://localhost:3081/entities<br>
    Accept: application/vnd.api+json

**or**

    GET http://localhost:3081/entities/ID[,ID,ID...]<br>
    Accept: application/vnd.api+json

### Query Parameters

None.

### HTTP Return Codes

Return code | Description
--------- | -----------
200 | OK


## Update entities

Update one or more attributes for one or more entity resources.

```shell
curl -w 'response: %{http_code} \n' -X PATCH -H "Content-Type: application/vnd.api+json" -d \
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

Flapjack::Diner.update_entities!('157', :name => 'www.example_com',
  :add_contacts => ['352'])
```

### HTTP Request

    PATCH http://localhost:3081/entities/ID[,ID,ID...]<br>
    Content-Type: application/vnd.api+json<br>
    Accept: application/vnd.api+json

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
405 | **Error** The submitted changes not sent with the JSONAPI MIME type `application/vnd.api+json`.
422 | **Error** The submitted contact data did not conform to the provided specification.


## Create scheduled maintenance periods on entities

```shell
```

```ruby
```

### HTTP Request

    POST http://localhost:3081/entities/ID[,ID,ID...]/scheduled_maintenances<br>
    Content-Type: application/json

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
```

```ruby
```

### HTTP Request

    DELETE http://localhost:3081/entities/ID[,ID,ID...]/scheduled_maintenances<br>
    Content-Type: application/json

### Query Parameters

Parameter | Type | Description
--------- | ---- | -----------
start_time | String | A date &amp; time in ISO 8601 format (YYYY-MM-DDThh:mm:ssZ)

### HTTP Return Codes

Return code | Description
--------- | -----------
204 | Matching unscheduled maintenance periods were deleted.
403 | **Error** The required 'start_time' parameter was not sent.
404 | **Error** No matching entities were found.


## Create unscheduled maintenance periods on entities

```shell
```

```ruby
```

### HTTP Request

    POST http://localhost:3081/entities/ID[,ID,ID...]/unscheduled_maintenances<br>
    Content-Type: application/json

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


## Delete unscheduled maintenance periods on entities

```shell
```

```ruby
```

### HTTP Request

    DELETE http://localhost:3081/entities/ID[,ID,ID...]/unscheduled_maintenances<br>
    Content-Type: application/json

### Query Parameters

Parameter | Type | Description
--------- | ---- | -----------
end_time | String | A date &amp; time in ISO 8601 format (YYYY-MM-DDThh:mm:ssZ), defaults to the current time if not provided

### HTTP Return Codes

Return code | Description
--------- | -----------
204 | Matching unscheduled maintenance periods were deleted.
404 | **Error** No matching entities were found.


## Create test notifications on entities

```shell
```

```ruby
```

### HTTP Request

    POST http://localhost:3081/entities/ID[,ID,ID...]/test_notifications<br>
    Content-Type: application/json

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
