```shell
curl -w 'response: %{http_code} \n' -X DELETE -H "Content-type: application/vnd.api+json; ext=bulk" -d \
 '{
    "data": [
      {
        "type": "unscheduled_maintenance",
        "id": "1092c169-100b-4e61-b18f-a49b9a7da8b8"
      }, {
        "type": "unscheduled_maintenance",
        "id": "b2eec6bb-fdd3-4980-9174-c1193443c49d"
      }
    ]
  }' \
 http://localhost:3081/unscheduled_maintenances
```

```ruby
require 'flapjack-diner'
Flapjack::Diner.base_uri('localhost:3081')

Flapjack::Diner.delete_unscheduled_maintenances(
  '1092c169-100b-4e61-b18f-a49b9a7da8b8',
  'b2eec6bb-fdd3-4980-9174-c1193443c49d'
)
```
