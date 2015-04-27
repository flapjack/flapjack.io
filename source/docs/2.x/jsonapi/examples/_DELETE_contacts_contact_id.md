```shell
curl -w 'response: %{http_code} \n' -X DELETE \
 http://localhost:3081/contacts/9313428a-3fcc-4444-8b68-8764252ca095
```

```ruby
require 'flapjack-diner'
Flapjack::Diner.base_uri('localhost:3081')

Flapjack::Diner.delete_contacts(
  '9313428a-3fcc-4444-8b68-8764252ca095'
)
```
