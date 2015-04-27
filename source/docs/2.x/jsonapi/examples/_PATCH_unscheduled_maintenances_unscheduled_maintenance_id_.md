```shell
curl -w 'response: %{http_code} \n' -X PATCH -H "Content-type: application/vnd.api+json" -d \
'{
  "data" : {
    "id": "1092c169-100b-4e61-b18f-a49b9a7da8b8",
    "type": "unscheduled_maintenance"
  }
}' \
 'http://localhost:3081/unscheduled_maintenances/1092c169-100b-4e61-b18f-a49b9a7da8b8'
```

```ruby
require 'flapjack-diner'
Flapjack::Diner.base_uri('localhost:3081')

Flapjack::Diner.update_unscheduled_maintenances(
  {:id => '1092c169-100b-4e61-b18f-a49b9a7da8b8',
   :end_time => '2015-01-07T13:50:00+10:00'}
)
```
