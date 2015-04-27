```shell
curl -w 'response: %{http_code} \n' -X DELETE \
 http://localhost:3081/scheduled_maintenances/e2c9332f-b5fc-4037-ba66-090654c3205b
```

```ruby
require 'flapjack-diner'
Flapjack::Diner.base_uri('localhost:3081')

Flapjack::Diner.delete_scheduled_maintenances(
  'e2c9332f-b5fc-4037-ba66-090654c3205b'
)
```
