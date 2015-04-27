```shell
curl -w 'response: %{http_code} \n' -X PATCH -H "Content-type: application/vnd.api+json" -d \
 '{
    "data": {
      "type": "check",
      "id": "2d6e8006-e220-4962-ab0f-248978abdc72"
      }
    ]
  }' \
 http://localhost:3081/unscheduled_maintenances/1092c169-100b-4e61-b18f-a49b9a7da8b8/links/check

# or

curl -w 'response: %{http_code} \n' -X PATCH -H "Content-type: application/vnd.api+json" -d \
 '{
    "data": null
  }' \
 http://localhost:3081/unscheduled_maintenances/1092c169-100b-4e61-b18f-a49b9a7da8b8/links/check
```

```ruby
require 'flapjack-diner'
Flapjack::Diner.base_uri('localhost:3081')

Flapjack::Diner.update_unscheduled_maintenances_link_check(
  '1092c169-100b-4e61-b18f-a49b9a7da8b8',
  '2d6e8006-e220-4962-ab0f-248978abdc72'
)

# or

Flapjack::Diner.update_unscheduled_maintenances_link_check(
  '1092c169-100b-4e61-b18f-a49b9a7da8b8',
  nil
)
```
