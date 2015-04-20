```shell
curl -w 'response: %{http_code} \n' -X DELETE -H "Content-type: application/vnd.api+json; ext=bulk" -d \
 '{
    "data": [
      {
        "type": "scheduled_maintenance",
        "id": "e2c9332f-b5fc-4037-ba66-090654c3205b"
      }, {
        "type": "scheduled_maintenance",
        "id": "1940e145-8de7-4271-831c-6a58bf5a04cb"
      }
    ]
  }' \
 http://localhost:3081/scheduled_maintenances
```

```ruby
require 'flapjack-diner'
Flapjack::Diner.base_uri('localhost:3081')

Flapjack::Diner.delete_scheduled_maintenances(
  'e2c9332f-b5fc-4037-ba66-090654c3205b',
  '1940e145-8de7-4271-831c-6a58bf5a04cb'
)
```
