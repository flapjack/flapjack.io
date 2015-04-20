```shell
curl -w 'response: %{http_code} \n' -X POST -H "Content-type: application/vnd.api+json" -d \
 '{
    "data": {
        "type": "scheduled_maintenance",
        "start_time": "2015-01-05T13:50:00+10:00",
        "end_time": "2015-01-06T13:50:00+10:00"
      }
  }' \
 http://localhost:3081/scheduled_maintenances

# or

curl -w 'response: %{http_code} \n' -X POST -H "Content-type: application/vnd.api+json; ext=bulk" -d \
 '{
    "data": [
      {
        "type": "scheduled_maintenance",
        "start_time": "2015-01-05T13:50:00+10:00",
        "end_time": "2015-01-06T13:50:00+10:00"
      }, {
        "type": "scheduled_maintenance",
        "start_time": "2015-01-12T13:50:00+10:00",
        "end_time": "2015-01-13T13:50:00+10:00"
      }
    ]
  }' \
 http://localhost:3081/scheduled_maintenances
```

```ruby
require 'flapjack-diner'
Flapjack::Diner.base_uri('localhost:3081')

Flapjack::Diner.create_scheduled_maintenances({
    :start_time => "2015-01-05T13:50:00+10:00",
    :end_time => "2015-01-06T13:50:00+10:00"
  })

# or

Flapjack::Diner.create_scheduled_maintenances({
    :start_time => "2015-01-05T13:50:00+10:00",
    :end_time => "2015-01-06T13:50:00+10:00"
  }, {
    :start_time => "2015-01-12T13:50:00+10:00",
    :end_time => "2015-01-13T13:50:00+10:00"
  })
```
