
# Checks


## Create scheduled maintenance periods on checks

```shell
curl -w 'response: %{http_code} \n' -X POST -H "Content-type: application/vnd.api+json" -d \
 '{
    "start_time" : "2014-04-09T16:03:25+09:30",
    "duration" : 3600,
    "summary" : "memory replacement"
  }' \
 http://localhost:3081/scheduled_maintenances/checks/example.com:SSH
```

```ruby
require 'flapjack-diner'
Flapjack::Diner.base_uri('localhost:3081')

Flapjack::Diner.create_scheduled_maintenances_checks(
  'example.com:SSH',
  :start_time => '2014-04-09T16:03:25+09:30',
  :duration   => 3600,
  :summary    => 'memory replacement'
)
```

### HTTP Request

`POST /scheduled_maintenances/checks/ID[,ID,ID...]`

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
404 | **Error** No matching checks were found.
405 | **Error** The submitted parameters were not sent with the JSONAPI MIME type `application/json`.


## Delete scheduled maintenance periods on checks

```shell
curl -w 'response: %{http_code} \n' -X DELETE \
  'http://localhost:3081/scheduled_maintenances/checks/example.com:PING?start_time=2014-05-09T16:12:16+09:30'
```

```ruby
require 'flapjack-diner'
Flapjack::Diner.base_uri('localhost:3081')

Flapjack::Diner.delete_scheduled_maintenances_checks(
  'example.com:PING',
  :end_time => '2014-05-09T16:12:16+09:30'
)
```

### HTTP Request

`DELETE /scheduled_maintenances/checks/ID[,ID,ID...]`

### Query Parameters

Parameter | Type | Description
--------- | ---- | -----------
start_time | String | A date &amp; time in ISO 8601 format (YYYY-MM-DDThh:mm:ssZ)

### HTTP Return Codes

Return code | Description
--------- | -----------
204 | Matching unscheduled maintenance periods were deleted.
403 | **Error** The required 'start_time' parameter was not sent.
404 | **Error** No matching checks were found.


## Create unscheduled maintenance periods on checks

```shell
curl -w 'response: %{http_code} \n' -X POST -H "Content-type: application/vnd.api+json" -d \
 '{
    "duration" : 3600,
    "summary" : "fixing now"
  }' \
 http://localhost:3081/unscheduled_maintenances/checks/example.com:HOST
```

```ruby
require 'flapjack-diner'
Flapjack::Diner.base_uri('localhost:3081')

Flapjack::Diner.create_unscheduled_maintenances_checks(
  'example.com:HOST',
  :duration => 3600,
  :summary  => 'fixing now'
)
```

### HTTP Request

`POST /unscheduled_maintenances/checks/ID[,ID,ID...]`

### Query Parameters

Parameter | Type | Description
--------- | ---- | -----------
duration | Integer | A length of time (in seconds) that the unscheduled maintenance period(s) should last.
summary | String | A summary of the reason for the creation of the unscheduled maintenance period(s).

### HTTP Return Codes

Return code | Description
--------- | -----------
204 | The submitted unscheduled maintenance periods were created successfully.
404 | **Error** No matching checks were found.
405 | **Error** The submitted parameters were not sent with the JSONAPI MIME type `application/json`.


## Update unscheduled maintenance periods on checks

```shell
curl -w 'response: %{http_code} \n' -X PATCH -H "Content-Type: application/json-patch+json" -d \
'[
  {"op"    : "replace",
   "path"  : "/unscheduled_maintenances/0/end_time",
   "value" : "2014-04-09T16:12:16+09:30"},
]' \
 'http://localhost:3081/unscheduled_maintenances/checks/example.com:PING'
```

```ruby
require 'flapjack-diner'
Flapjack::Diner.base_uri('localhost:3081')

Flapjack::Diner.update_unscheduled_maintenances_checks(
  'example.com:PING',
  :end_time => '2014-04-09T16:12:16+09:30'
)
```

### HTTP Request

`PATCH /unscheduled_maintenances/checks/ID[,ID,ID...]`

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
404 | Entity/check resources could not be found for one or more of the provided ids. No unscheduled maintenance periods were altered by this request.
405 | **Error** The submitted data was not sent with the JSON-Patch MIME type `application/json-patch+json`.


## Create test notifications on checks

```shell
curl -w 'response: %{http_code} \n' -X POST -H "Content-type: application/vnd.api+json" -d \
 '{
    "summary" : "testing, testing, 1, 2, 3"
  }' \
 http://localhost:3081/test_notifications/checks/example.com:HOST
```

```ruby
require 'flapjack-diner'
Flapjack::Diner.base_uri('localhost:3081')

Flapjack::Diner.create_test_notifications_checks(
  'example.com:HOST',
  :summary => 'testing, testing, 1, 2, 3'
)
```

### HTTP Request

`POST /test_notifications/checks/ID[,ID,ID...]`

### Query Parameters

Parameter | Type | Description
--------- | ---- | -----------
summary | String | A summary of the reason for the creation of the test notifications.

### HTTP Return Codes

Return code | Description
--------- | -----------
204 | The submitted test notifications were created successfully.
404 | **Error** No matching checks were found.
405 | **Error** The submitted parameters were not sent with the JSONAPI MIME type `application/json`.
