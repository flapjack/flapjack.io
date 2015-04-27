```shell
curl -w 'response: %{http_code} \n' -X PATCH -H "Content-type: application/vnd.api+json; ext=bulk" -d \
'{
  "data" : [
    {
      "id": "database",
      "type": "tag",
    }, {
      "id": "virtual",
      "type": "tag",
    }
  ]
}' \
 'http://localhost:3081/tags
```

```ruby
require 'flapjack-diner'
Flapjack::Diner.base_uri('localhost:3081')

Flapjack::Diner.update_tags(
  {:id => 'database'},
  {:id => 'virtual'}
)
```
