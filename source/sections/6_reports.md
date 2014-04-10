
# Reports


## Get report on status of entities or checks

```shell
curl http://localhost:3081/entities/status_report
# or
curl http://localhost:3081/enities/76/status_report
# or
curl http://localhost:3081/entities/76,342/status_report
# or
curl http://localhost:3081/checks/status_report
# or
curl http://localhost:3081/checks/www.example.com:PING/status_report
# or
curl http://localhost:3081/checks/www.example.com:PING,www.example2.com:SSH/status_report
```

```ruby
require 'flapjack-diner'
Flapjack::Diner.base_uri('localhost:3081')

Flapjack::Diner.entities_status_report
# or
Flapjack::Diner.entities_status_report('76')
# or
Flapjack::Diner.entities_status_report('76', '342')
# or
Flapjack::Diner.checks_status_report
# or
Flapjack::Diner.checks_status_report('www.example.com:PING')
# or
Flapjack::Diner.checks_status_report('www.example.com:PING', 'www.example2.com:SSH')
```

### HTTP Request

`GET /entities/status_report`

or

`GET /entities/ID[,ID,ID...]/status_report`

or

`GET /checks/status_report`

or

`GET /checks/ID[,ID,ID...]/status_report`

### Query Parameters

None.

### HTTP Return Codes

Return code | Description
--------- | -----------
200 | OK


## Get report on unscheduled maintenance periods of entities or checks

```shell
curl http://localhost:3081/entities/unscheduled_maintenance_report
# or
curl http://localhost:3081/enities/76/unscheduled_maintenance_report
# or
curl http://localhost:3081/entities/76,342/unscheduled_maintenance_report
# or
curl http://localhost:3081/checks/unscheduled_maintenance_report
# or
curl http://localhost:3081/checks/www.example.com:PING/unscheduled_maintenance_report
# or
curl http://localhost:3081/checks/www.example.com:PING,www.example2.com:SSH/unscheduled_maintenance_report
```

```ruby
require 'flapjack-diner'
Flapjack::Diner.base_uri('localhost:3081')

Flapjack::Diner.entities_unscheduled_maintenance_report
# or
Flapjack::Diner.entities_unscheduled_maintenance_report('76')
# or
Flapjack::Diner.entities_unscheduled_maintenance_report('76', '342')
# or
Flapjack::Diner.checks_unscheduled_maintenance_report
# or
Flapjack::Diner.checks_unscheduled_maintenance_report('www.example.com:PING')
# or
Flapjack::Diner.checks_unscheduled_maintenance_report('www.example.com:PING', 'www.example2.com:SSH')
```

### HTTP Request

`GET /entities/unscheduled_maintenance_report`

or

`GET /entities/ID[,ID,ID...]/unscheduled_maintenance_report`

or

`GET /checks/unscheduled_maintenance_report`

or

`GET /checks/ID[,ID,ID...]/unscheduled_maintenance_report`

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
curl http://localhost:3081/entities/scheduled_maintenance_report
# or
curl http://localhost:3081/enities/76/scheduled_maintenance_report
# or
curl http://localhost:3081/entities/76,342/scheduled_maintenance_report
# or
curl http://localhost:3081/checks/scheduled_maintenance_report
# or
curl http://localhost:3081/checks/www.example.com:PING/scheduled_maintenance_report
# or
curl http://localhost:3081/checks/www.example.com:PING,www.example2.com:SSH/scheduled_maintenance_report
```

```ruby
require 'flapjack-diner'
Flapjack::Diner.base_uri('localhost:3081')

Flapjack::Diner.entities_scheduled_maintenance_report
# or
Flapjack::Diner.entities_scheduled_maintenance_report('76')
# or
Flapjack::Diner.entities_scheduled_maintenance_report('76', '342')
# or
Flapjack::Diner.checks_scheduled_maintenance_report
# or
Flapjack::Diner.checks_scheduled_maintenance_report('www.example.com:PING')
# or
Flapjack::Diner.checks_scheduled_maintenance_report('www.example.com:PING', 'www.example2.com:SSH')
```

### HTTP Request

`GET /entities/scheduled_maintenance_report`

or

`GET /entities/ID[,ID,ID...]/scheduled_maintenance_report`

or

`GET /checks/scheduled_maintenance_report`

or

`GET /checks/ID[,ID,ID...]/scheduled_maintenance_report`

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
curl http://localhost:3081/entities/outage_report
# or
curl http://localhost:3081/enities/76/outage_report
# or
curl http://localhost:3081/entities/76,342/outage_report
# or
curl http://localhost:3081/checks/outage_report
# or
curl http://localhost:3081/checks/www.example.com:PING/outage_report
# or
curl http://localhost:3081/checks/www.example.com:PING,www.example2.com:SSH/outage_report
```

```ruby
require 'flapjack-diner'
Flapjack::Diner.base_uri('localhost:3081')

Flapjack::Diner.entities_outage_report
# or
Flapjack::Diner.entities_outage_report('76')
# or
Flapjack::Diner.entities_outage_report('76', '342')
# or
Flapjack::Diner.checks_outage_report
# or
Flapjack::Diner.checks_outage_report('www.example.com:PING')
# or
Flapjack::Diner.checks_outage_report('www.example.com:PING', 'www.example2.com:SSH')
```

### HTTP Request

`GET /entities/outage_report`

or

`GET /entities/ID[,ID,ID...]/outage_report`

or

`GET /checks/outage_report`

or

`GET /checks/ID[,ID,ID...]/outage_report`

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
curl http://localhost:3081/entities/downtime_report
# or
curl http://localhost:3081/enities/76/downtime_report
# or
curl http://localhost:3081/entities/76,342/downtime_report
# or
curl http://localhost:3081/checks/downtime_report
# or
curl http://localhost:3081/checks/www.example.com:PING/downtime_report
# or
curl http://localhost:3081/checks/www.example.com:PING,www.example2.com:SSH/downtime_report
```

```ruby
require 'flapjack-diner'
Flapjack::Diner.base_uri('localhost:3081')

Flapjack::Diner.entities_downtime_report
# or
Flapjack::Diner.entities_downtime_report('76')
# or
Flapjack::Diner.entities_downtime_report('76', '342')
# or
Flapjack::Diner.checks_downtime_report
# or
Flapjack::Diner.checks_downtime_report('www.example.com:PING')
# or
Flapjack::Diner.checks_downtime_report('www.example.com:PING', 'www.example2.com:SSH')
```

### HTTP Request

`GET /entities/downtime_report`

or

`GET /entities/ID[,ID,ID...]/downtime_report`

or

`GET /checks/downtime_report`

or

`GET /checks/ID[,ID,ID...]/downtime_report`

### Query Parameters

Parameter | Type | Description
--------- | ---- | -----------
start_time | String | A date &amp; time in ISO 8601 format (YYYY-MM-DDThh:mm:ssZ)
end_time | String | A date &amp; time in ISO 8601 format (YYYY-MM-DDThh:mm:ssZ)

### HTTP Return Codes

Return code | Description
--------- | -----------
200 | OK
