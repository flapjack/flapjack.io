```shell
curl -w 'response: %{http_code} \n' -X DELETE \
 http://localhost:3081/tags/database
```

```ruby
require 'flapjack-diner'
Flapjack::Diner.base_uri('localhost:3081')

Flapjack::Diner.delete_tags('database')
```
