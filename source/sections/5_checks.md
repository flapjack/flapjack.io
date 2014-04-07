
# Checks


## Create scheduled maintenance periods on checks

```shell
```

```ruby
```

### HTTP Request

    POST http://localhost:3081/checks/ID[,ID,ID...]/scheduled_maintenances<br>
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
404 | **Error** No matching checks were found.
405 | **Error** The submitted parameters were not sent with the JSONAPI MIME type `application/json`.


## Delete scheduled maintenance periods on checks

```shell
```

```ruby
```

### HTTP Request

    DELETE http://localhost:3081/checks/ID[,ID,ID...]/scheduled_maintenances<br>
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
404 | **Error** No matching checks were found.


## Create unscheduled maintenance periods on checks

```shell
```

```ruby
```

### HTTP Request

    POST http://localhost:3081/checks/ID[,ID,ID...]/unscheduled_maintenances<br>
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
404 | **Error** No matching checks were found.
405 | **Error** The submitted parameters were not sent with the JSONAPI MIME type `application/json`.


## Delete unscheduled maintenance periods on checks

```shell
```

```ruby
```

### HTTP Request

    DELETE http://localhost:3081/checks/ID[,ID,ID...]/unscheduled_maintenances<br>
    Content-Type: application/json

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
```

```ruby
```

### HTTP Request

    POST http://localhost:3081/checks/ID[,ID,ID...]/test_notifications<br>
    Content-Type: application/json

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
