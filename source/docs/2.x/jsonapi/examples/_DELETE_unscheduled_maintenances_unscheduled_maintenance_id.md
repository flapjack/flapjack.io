```shell
curl -w 'response: %{http_code} \n' -X DELETE \
 http://localhost:3081/unscheduled_maintenances/1092c169-100b-4e61-b18f-a49b9a7da8b8
```

```ruby
require 'flapjack-diner'
Flapjack::Diner.base_uri('localhost:3081')

Flapjack::Diner.delete_unscheduled_maintenances(
  '1092c169-100b-4e61-b18f-a49b9a7da8b8'
)
```
