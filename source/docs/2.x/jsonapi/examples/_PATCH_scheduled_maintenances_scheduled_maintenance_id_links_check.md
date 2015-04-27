```shell
curl -w 'response: %{http_code} \n' -X PATCH -H "Content-type: application/vnd.api+json" -d \
 '{
    "data": {
      "type": "check",
      "id": "2d6e8006-e220-4962-ab0f-248978abdc72"
      }
    ]
  }' \
 http://localhost:3081/scheduled_maintenances/e2c9332f-b5fc-4037-ba66-090654c3205b/links/check

# or

curl -w 'response: %{http_code} \n' -X PATCH -H "Content-type: application/vnd.api+json" -d \
 '{
    "data": null
  }' \
 http://localhost:3081/scheduled_maintenances/e2c9332f-b5fc-4037-ba66-090654c3205b/links/check
```

```ruby
require 'flapjack-diner'
Flapjack::Diner.base_uri('localhost:3081')

Flapjack::Diner.update_scheduled_maintenances_link_check(
  'e2c9332f-b5fc-4037-ba66-090654c3205b',
  '2d6e8006-e220-4962-ab0f-248978abdc72'
)

# or

Flapjack::Diner.update_scheduled_maintenances_link_check(
  'e2c9332f-b5fc-4037-ba66-090654c3205b',
  nil
)
```
