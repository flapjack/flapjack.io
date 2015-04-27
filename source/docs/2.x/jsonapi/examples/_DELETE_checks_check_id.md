```shell
curl -w 'response: %{http_code} \n' -X DELETE \
 http://localhost:3081/checks/2d6e8006-e220-4962-ab0f-248978abdc72
```

```ruby
require 'flapjack-diner'
Flapjack::Diner.base_uri('localhost:3081')

Flapjack::Diner.delete_checks(
  '2d6e8006-e220-4962-ab0f-248978abdc72'
)
```
