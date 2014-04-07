
# Reports


## Get report on status of entities & checks

```shell
```

```ruby
require 'flapjack-diner'
Flapjack::Diner.base_uri('localhost:3081')

Flapjack::Diner.status('www.example.com', 'www.example2.com:SSH')
```

### HTTP Request

    GET http://localhost:3081/reports/status<br>
    Content-Type: application/json
    Accept: application/vnd.api+json

### Query Parameters

Parameter | Type | Description
--------- | ---- | -----------
entities | Array[String] | An array of entity names to create scheduled maintenance periods for.
checks | Array[String] | An array of entity:check compound names to create scheduled maintenance periods for.

### HTTP Return Codes

Return code | Description
--------- | -----------
200 | OK


## Get report on unscheduled maintenance periods of entities & checks

```shell
```

```ruby
require 'flapjack-diner'
Flapjack::Diner.base_uri('localhost:3081')

```

### HTTP Request

    GET http://localhost:3081/reports/unscheduled_maintenances<br>
    Content-Type: application/json
    Accept: application/vnd.api+json

### Query Parameters

Parameter | Type | Description
--------- | ---- | -----------
entities | Array[String] | An array of entity names to create scheduled maintenance periods for.
checks | Array[String] | An array of entity:check compound names to create scheduled maintenance periods for.
start_time | String | A date &amp; time in ISO 8601 format (YYYY-MM-DDThh:mm:ssZ)
end_time | String | A date &amp; time in ISO 8601 format (YYYY-MM-DDThh:mm:ssZ)

### HTTP Return Codes

Return code | Description
--------- | -----------
200 | OK


## Get report on scheduled maintenance periods of entities & checks

```shell
```

```ruby
require 'flapjack-diner'
Flapjack::Diner.base_uri('localhost:3081')

```

### HTTP Request

    GET http://localhost:3081/reports/scheduled_maintenances<br>
    Content-Type: application/json
    Accept: application/vnd.api+json

### Query Parameters

Parameter | Type | Description
--------- | ---- | -----------
entities | Array[String] | An array of entity names to create scheduled maintenance periods for.
checks | Array[String] | An array of entity:check compound names to create scheduled maintenance periods for.
start_time | String | A date &amp; time in ISO 8601 format (YYYY-MM-DDThh:mm:ssZ)
end_time | String | A date &amp; time in ISO 8601 format (YYYY-MM-DDThh:mm:ssZ)

### HTTP Return Codes

Return code | Description
--------- | -----------
200 | OK


## Get report on outages of entities & checks

```shell
```

```ruby
require 'flapjack-diner'
Flapjack::Diner.base_uri('localhost:3081')

```

### HTTP Request

### Query Parameters

Parameter | Type | Description
--------- | ---- | -----------
entities | Array[String] | An array of entity names to create scheduled maintenance periods for.
checks | Array[String] | An array of entity:check compound names to create scheduled maintenance periods for.
start_time | String | A date &amp; time in ISO 8601 format (YYYY-MM-DDThh:mm:ssZ)
end_time | String | A date &amp; time in ISO 8601 format (YYYY-MM-DDThh:mm:ssZ)

### HTTP Return Codes

Return code | Description
--------- | -----------
200 | OK


## Get report on downtime of entities & checks

```shell
```

```ruby
require 'flapjack-diner'
Flapjack::Diner.base_uri('localhost:3081')

```

### HTTP Request

### Query Parameters

Parameter | Type | Description
--------- | ---- | -----------
entities | Array[String] | An array of entity names to create scheduled maintenance periods for.
checks | Array[String] | An array of entity:check compound names to create scheduled maintenance periods for.
start_time | String | A date &amp; time in ISO 8601 format (YYYY-MM-DDThh:mm:ssZ)
end_time | String | A date &amp; time in ISO 8601 format (YYYY-MM-DDThh:mm:ssZ)

### HTTP Return Codes

Return code | Description
--------- | -----------
200 | OK
