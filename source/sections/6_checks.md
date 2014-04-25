
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
  ['example.com:SSH'],
  :start_time => '2014-04-09T16:03:25+09:30',
  :duration   => 3600,
  :summary    => 'memory replacement')
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
  ['example.com:PING'],
  :end_time => '2014-05-09T16:12:16+09:30')
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
  ['example.com:HOST'],
  :duration => 3600,
  :summary  => 'fixing now')
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


## Delete unscheduled maintenance periods on checks

```shell
curl -w 'response: %{http_code} \n' -X DELETE \
  'http://localhost:3081/unscheduled_maintenances/checks/example.com:PING?end_time=2014-04-09T16:12:16+09:30'
```

```ruby
require 'flapjack-diner'
Flapjack::Diner.base_uri('localhost:3081')

Flapjack::Diner.delete_unscheduled_maintenances_checks(
  ['example.com:PING'],
  :end_time => '2014-04-09T16:12:16+09:30')
```

### HTTP Request

`DELETE /unscheduled_maintenances/checks/ID[,ID,ID...]`

### Query Parameters

Parameter | Type | Description
--------- | ---- | -----------
end_time | String | A date &amp; time in ISO 8601 format (YYYY-MM-DDThh:mm:ssZ), defaults to the current time if not provided

### HTTP Return Codes

Return code | Description
--------- | -----------
204 | Matching unscheduled maintenance periods were deleted.
404 | **Error** No matching checks were found.


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
  ['example.com:HOST'],
  :summary => 'testing, testing, 1, 2, 3')
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
