```shell
curl -w 'response: %{http_code} \n' -X PATCH -H "Content-type: application/vnd.api+json; ext=bulk" -d \
'{
  "data" : [
    {
      "id": "1092c169-100b-4e61-b18f-a49b9a7da8b8",
      "type": "unscheduled_maintenance",
      "end_time": "2015-01-07T13:50:00+10:00"
    }, {
      "id": "b2eec6bb-fdd3-4980-9174-c1193443c49d",
      "type": "unscheduled_maintenance",
      "end_time": "2015-01-14T13:50:00+10:00"
    }
  ]
}' \
 'http://localhost:3081/unscheduled_maintenances
```

```ruby
require 'flapjack-diner'
Flapjack::Diner.base_uri('localhost:3081')

Flapjack::Diner.update_unscheduled_maintenances(
  {:id => '1092c169-100b-4e61-b18f-a49b9a7da8b8',
   :end_time => '2015-01-07T13:50:00+10:00'},
  {:id => 'b2eec6bb-fdd3-4980-9174-c1193443c49d',
   :end_time => '2015-01-14T13:50:00+10:00'}
)
```
