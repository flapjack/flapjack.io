```shell
curl -w 'response: %{http_code} \n' -X PATCH -H "Content-type: application/vnd.api+json" -d \
'{
  "data" : {
    "id": "database",
    "type": "tag"
  }
}' \
 'http://localhost:3081/tags/database'
```

```ruby
require 'flapjack-diner'
Flapjack::Diner.base_uri('localhost:3081')

Flapjack::Diner.update_tags(
  {:id => 'database'}
)
```
