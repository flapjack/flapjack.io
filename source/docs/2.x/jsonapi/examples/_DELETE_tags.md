```shell
curl -w 'response: %{http_code} \n' -X DELETE -H "Content-type: application/vnd.api+json; ext=bulk" -d \
 '{
    "data": [
      {
        "type": "tag",
        "id": "database"
      }, {
        "type": "tag",
        "id": "virtual"
      }
    ]
  }' \
 http://localhost:3081/tags
```

```ruby
require 'flapjack-diner'
Flapjack::Diner.base_uri('localhost:3081')

Flapjack::Diner.delete_tags('database', 'virtual')
```
