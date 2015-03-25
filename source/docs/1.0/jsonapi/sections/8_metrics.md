# Metrics

These endpoints are all new in Flapjack 1.5.0 with the exception of `GET /metrics` which appeared a good long time ago.

## Check Freshness

Returns the freshness distribution of all active checks in flapjack. This is the count of checks in defined age bands as follows:

* between 0 and 1 minutes
* between 1 and 5 minutes
* between 5 and 15 minutes
* between 15 minutes and 1 hour
* greater than 1 hour

```shell
curl http://localhost:3081/metrics/check_freshness
```

```ruby
require 'flapjack-diner'
Flapjack::Diner.base_uri('localhost:3081')

Flapjack::Diner.metrics_check_freshness
```

```json
{
  "check_freshness": {
    "0": 0,
    "60": 0,
    "300": 0,
    "900": 0,
    "3600": 9
  }
}
```

### HTTP Request

`GET /metrics/check_freshness`

### Query Parameters

None.

### HTTP Return Codes

Return code | Description
--------- | -----------
200 | OK

## Checks Summary

Returns some statistics about checks:

* total number of checks
* number of failing checks

```shell
curl http://localhost:3081/metrics/checks
```

```ruby
require 'flapjack-diner'
Flapjack::Diner.base_uri('localhost:3081')

Flapjack::Diner.metrics_checks
```

```json
{
  "checks": {
    "all": 9,
    "failing": 3
  }
}
```

### HTTP Request

`GET /metrics/checks`

### Query Parameters

None.

### HTTP Return Codes

Return code | Description
--------- | -----------
200 | OK

## Entities Summary

Returns some statistics about entities:

* total number of entities
* number of entities with at least one failing check

```shell
curl http://localhost:3081/metrics/entities
```

```ruby
require 'flapjack-diner'
Flapjack::Diner.base_uri('localhost:3081')

Flapjack::Diner.metrics_entities
```

```json
{
  "entities": {
    "all": 10,
    "enabled": 7,
    "failing": 3
  }
}
```

### HTTP Request

`GET /metrics/entities`

### Query Parameters

None.

### HTTP Return Codes

Return code | Description
--------- | -----------
200 | OK


## Events

Returns statistics about the processing of events (check execution results) received by Flapjack as follows:

* The number of events processed:

  * in total
  * that had a failure state (eg 'warning', 'critical', 'unknown')
  * that had an ok state
  * that were action events (eg 'acknowledgement')
  * that were discarded due to being invalid

* The size (length) of the event queue. This number should often be zero otherwise Flapjack is not keeping up with the events being fed in from the check executors for processing.

```shell
curl http://localhost:3081/metrics/events
```

```ruby
require 'flapjack-diner'
Flapjack::Diner.base_uri('localhost:3081')

Flapjack::Diner.metrics_events
```

```json
{
  "events":
  {
    "processed": {
      "all": 153,
      "failure": 104,
      "ok": 12,
      "invalid": 29,
      "action": 8
    },
    "queue": {
      "length": 0
    }
  }
}
```

### HTTP Request

`GET /metrics/events`

### Query Parameters

None.

### HTTP Return Codes

Return code | Description
--------- | -----------
200 | OK


## All Metrics

Returns all of the above metrics in one http transaction, although the data structure is not exactly a straight composite. It also includes the PID of the API process, and the FQDN of the server hosting the Flapjack API. ¯\\_(ツ)_/¯

Note, this endpoint was written a while back and doesn't conform to JSONAPI. It will change in the next major release of Flapjack (2.0).

```shell
curl http://localhost:3081/metrics
```

```ruby
require 'flapjack-diner'
Flapjack::Diner.base_uri('localhost:3081')

Flapjack::Diner.metrics
```

```json
{
   "checks" : {
      "all" : 9,
      "failing" : 3
   },
   "check_freshness" : {
      "3600" : 9,
      "60" : 0,
      "900" : 0,
      "0" : 0,
      "300" : 0
   },
   "event_queue_length" : 0,
   "pid" : 3908,
   "entities" : {
      "all" : 10,
      "enabled" : 7,
      "failing" : 3
   },
   "total_keys" : 246,
   "processed_events_all_time" : {
      "all_time" : {
         "invalid" : 34,
         "ok" : 12,
         "all" : 158,
         "action" : 8,
         "failure" : 104
      }
   },
   "fqdn" : "Limiting-Factor.local"
}
```

### HTTP Request

`GET /metrics`

### Query Parameters

None.

### HTTP Return Codes

Return code | Description
--------- | -----------
200 | OK
