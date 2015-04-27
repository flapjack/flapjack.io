```shell
curl -w 'response: %{http_code} \n' -X PATCH -H "Content-type: application/vnd.api+json" -d \
'{
  "data" : {
    "id": "e2c9332f-b5fc-4037-ba66-090654c3205b",
    "type": "scheduled_maintenance"
  }
}' \
 'http://localhost:3081/scheduled_maintenances/e2c9332f-b5fc-4037-ba66-090654c3205b'
```

```ruby
require 'flapjack-diner'
Flapjack::Diner.base_uri('localhost:3081')

Flapjack::Diner.update_scheduled_maintenances(
  {:id => 'e2c9332f-b5fc-4037-ba66-090654c3205b',
   :end_time => '2015-01-07T13:50:00+10:00'}
)
```
