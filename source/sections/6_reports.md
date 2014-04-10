
# Reports


## Get report on status of entities or checks

```shell
curl http://localhost:3081/status_report/entities
# or
curl http://localhost:3081/status_report/entities/76
# or
curl http://localhost:3081/status_report/entities/76,342
# or
curl http://localhost:3081/status_report/checks
# or
curl http://localhost:3081/status_report/checks/www.example.com:PING
# or
curl http://localhost:3081/status_report/checks/www.example.com:PING,www.example2.com:SSH
```

```ruby
require 'flapjack-diner'
Flapjack::Diner.base_uri('localhost:3081')

Flapjack::Diner.status_report_entities
# or
Flapjack::Diner.status_report_entities('76')
# or
Flapjack::Diner.status_report_entities('76', '342')
# or
Flapjack::Diner.status_report_checks
# or
Flapjack::Diner.status_report_checks('www.example.com:PING')
# or
Flapjack::Diner.status_report_checks('www.example.com:PING', 'www.example2.com:SSH')
```

### HTTP Request

    GET http://localhost:3081/status_report/entities<br>
    Accept: application/vnd.api+json

or

    GET http://localhost:3081/status_report/entities/ID[,ID,ID...]/<br>
    Accept: application/vnd.api+json

or

    GET http://localhost:3081/status_report/checks<br>
    Accept: application/vnd.api+json

or

    GET http://localhost:3081/status_report/checks/ID[,ID,ID...]<br>
    Accept: application/vnd.api+json

### Query Parameters

None.

### HTTP Return Codes

Return code | Description
--------- | -----------
200 | OK


## Get report on unscheduled maintenance periods of entities or checks

```shell
curl http://localhost:3081/unscheduled_maintenance_report/entities
# or
curl http://localhost:3081/unscheduled_maintenance_report/entities/76
# or
curl http://localhost:3081/unscheduled_maintenance_report/entities/76,342
# or
curl http://localhost:3081/unscheduled_maintenance_report/checks
# or
curl http://localhost:3081/unscheduled_maintenance_report/checks/www.example.com:PING
# or
curl http://localhost:3081/unscheduled_maintenance_report/checks/www.example.com:PING,www.example2.com:SSH
```

```ruby
require 'flapjack-diner'
Flapjack::Diner.base_uri('localhost:3081')

Flapjack::Diner.unscheduled_maintenance_report_entities
# or
Flapjack::Diner.unscheduled_maintenance_report_entities('76')
# or
Flapjack::Diner.unscheduled_maintenance_report_entities('76', '342')
# or
Flapjack::Diner.unscheduled_maintenance_report_checks
# or
Flapjack::Diner.unscheduled_maintenance_report_checks('www.example.com:PING')
# or
Flapjack::Diner.unscheduled_maintenance_report_checks('www.example.com:PING', 'www.example2.com:SSH')
```

### HTTP Request

    GET http://localhost:3081/unscheduled_maintenance_report/entities<br>
    Accept: application/vnd.api+json

or

    GET http://localhost:3081/unscheduled_maintenance_report/entities/ID[,ID,ID...]<br>
    Accept: application/vnd.api+json

or

    GET http://localhost:3081/unscheduled_maintenance_report/checks<br>
    Accept: application/vnd.api+json

or

    GET http://localhost:3081/unscheduled_maintenance_report/checks/ID[,ID,ID...]<br>
    Accept: application/vnd.api+json

### Query Parameters

Parameter | Type | Description
--------- | ---- | -----------
start_time | String | A date &amp; time in ISO 8601 format (YYYY-MM-DDThh:mm:ssZ)
end_time | String | A date &amp; time in ISO 8601 format (YYYY-MM-DDThh:mm:ssZ)

### HTTP Return Codes

Return code | Description
--------- | -----------
200 | OK


## Get report on scheduled maintenance periods of entities or checks

```shell
curl http://localhost:3081/scheduled_maintenance_report/entities/
# or
curl http://localhost:3081/scheduled_maintenance_report/entities/76
# or
curl http://localhost:3081/scheduled_maintenance_report/entities/76,342
# or
curl http://localhost:3081/scheduled_maintenance_report/checks/
# or
curl http://localhost:3081/scheduled_maintenance_report/checks/www.example.com:PING
# or
curl http://localhost:3081/scheduled_maintenance_report/checks/www.example.com:PING,www.example2.com:SSH
```

```ruby
require 'flapjack-diner'
Flapjack::Diner.base_uri('localhost:3081')

Flapjack::Diner.scheduled_maintenance_report_entities
# or
Flapjack::Diner.scheduled_maintenance_report_entities('76')
# or
Flapjack::Diner.scheduled_maintenance_report_entities('76', '342')
# or
Flapjack::Diner.scheduled_maintenance_report_checks
# or
Flapjack::Diner.scheduled_maintenance_report_checks('www.example.com:PING')
# or
Flapjack::Diner.scheduled_maintenance_report_checks('www.example.com:PING', 'www.example2.com:SSH')
```

### HTTP Request

    GET http://localhost:3081/scheduled_maintenance_report/entities<br>
    Accept: application/vnd.api+json

or

    GET http://localhost:3081/scheduled_maintenance_report/entities/ID[,ID,ID...]<br>
    Accept: application/vnd.api+json

or

    GET http://localhost:3081/scheduled_maintenance_report/checks<br>
    Accept: application/vnd.api+json

or

    GET http://localhost:3081/scheduled_maintenance_report/checks/ID[,ID,ID...]<br>
    Accept: application/vnd.api+json

### Query Parameters

Parameter | Type | Description
--------- | ---- | -----------
start_time | String | A date &amp; time in ISO 8601 format (YYYY-MM-DDThh:mm:ssZ)
end_time | String | A date &amp; time in ISO 8601 format (YYYY-MM-DDThh:mm:ssZ)

### HTTP Return Codes

Return code | Description
--------- | -----------
200 | OK


## Get report on outages of entities or checks

```shell
curl http://localhost:3081/outage_report/entities
# or
curl http://localhost:3081/outage_report/entities/76
# or
curl http://localhost:3081/outage_report/entities/76,342
# or
curl http://localhost:3081/outage_report/checks
# or
curl http://localhost:3081/outage_report/checks/www.example.com:PING
# or
curl http://localhost:3081/outage_report/checks/www.example.com:PING,www.example2.com:SSH
```

```ruby
require 'flapjack-diner'
Flapjack::Diner.base_uri('localhost:3081')

Flapjack::Diner.outage_report_entities
# or
Flapjack::Diner.outage_report_entities('76')
# or
Flapjack::Diner.outage_report_entities('76', '342')
# or
Flapjack::Diner.outage_report_checks
# or
Flapjack::Diner.outage_report_checks('www.example.com:PING')
# or
Flapjack::Diner.outage_report_checks('www.example.com:PING', 'www.example2.com:SSH')
```

### HTTP Request

    GET http://localhost:3081/outage_report/entities<br>
    Accept: application/vnd.api+json

or

    GET http://localhost:3081/outage_report/entities/ID[,ID,ID...]<br>
    Accept: application/vnd.api+json

or

    GET http://localhost:3081/outage_report/checks<br>
    Accept: application/vnd.api+json

or

    GET http://localhost:3081/outage_report/checks/ID[,ID,ID...]<br>
    Accept: application/vnd.api+json

### Query Parameters

Parameter | Type | Description
--------- | ---- | -----------
start_time | String | A date &amp; time in ISO 8601 format (YYYY-MM-DDThh:mm:ssZ)
end_time | String | A date &amp; time in ISO 8601 format (YYYY-MM-DDThh:mm:ssZ)

### HTTP Return Codes

Return code | Description
--------- | -----------
200 | OK


## Get report on downtime of entities or checks

```shell
curl http://localhost:3081/downtime_report/entities
# or
curl http://localhost:3081/downtime_report/entities/76
# or
curl http://localhost:3081/downtime_report/entities/76,342
# or
curl http://localhost:3081/downtime_report/checks
# or
curl http://localhost:3081/downtime_report/checks/www.example.com:PING
# or
curl http://localhost:3081/downtime_report/checks/www.example.com:PING,www.example2.com:SSH
```

```ruby
require 'flapjack-diner'
Flapjack::Diner.base_uri('localhost:3081')

Flapjack::Diner.downtime_report_entities
# or
Flapjack::Diner.downtime_report_entities('76')
# or
Flapjack::Diner.downtime_report_entities('76', '342')
# or
Flapjack::Diner.downtime_report_checks
# or
Flapjack::Diner.downtime_report_checks('www.example.com:PING')
# or
Flapjack::Diner.downtime_report_checks('www.example.com:PING', 'www.example2.com:SSH')
```

### HTTP Request

    GET http://localhost:3081/downtime_report/entities<br>
    Accept: application/vnd.api+json

or

    GET http://localhost:3081/downtime_report/entities/ID[,ID,ID...]<br>
    Accept: application/vnd.api+json

or

    GET http://localhost:3081/downtime_report/checks<br>
    Accept: application/vnd.api+json

or

    GET http://localhost:3081/downtime_report/checks/ID[,ID,ID...]<br>
    Accept: application/vnd.api+json

### Query Parameters

Parameter | Type | Description
--------- | ---- | -----------
start_time | String | A date &amp; time in ISO 8601 format (YYYY-MM-DDThh:mm:ssZ)
end_time | String | A date &amp; time in ISO 8601 format (YYYY-MM-DDThh:mm:ssZ)

### HTTP Return Codes

Return code | Description
--------- | -----------
200 | OK
