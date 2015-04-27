```shell
curl -w 'response: %{http_code} \n' -X PATCH -H "Content-type: application/vnd.api+json; ext=bulk" -d \
'{
  "data" : [
    {
      "id": "e2c9332f-b5fc-4037-ba66-090654c3205b",
      "type": "scheduled_maintenance",
      "end_time": "2015-01-07T13:50:00+10:00"
    }, {
      "id": "1940e145-8de7-4271-831c-6a58bf5a04cb",
      "type": "scheduled_maintenance",
      "end_time": "2015-01-14T13:50:00+10:00"
    }
  ]
}' \
 'http://localhost:3081/scheduled_maintenances
```

```ruby
require 'flapjack-diner'
Flapjack::Diner.base_uri('localhost:3081')

Flapjack::Diner.update_scheduled_maintenances(
  {:id => 'e2c9332f-b5fc-4037-ba66-090654c3205b',
   :end_time => '2015-01-07T13:50:00+10:00'},
  {:id => '1940e145-8de7-4271-831c-6a58bf5a04cb',
   :end_time => '2015-01-13T13:50:00+10:00'}
)
```
