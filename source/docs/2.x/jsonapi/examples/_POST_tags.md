```shell
curl -w 'response: %{http_code} \n' -X POST -H "Content-type: application/vnd.api+json" -d \
 '{
    "data": {
        "type": "tag",
        "name": "database"
      }
  }' \
 http://localhost:3081/tags

# or

curl -w 'response: %{http_code} \n' -X POST -H "Content-type: application/vnd.api+json; ext=bulk" -d \
 '{
    "data": [
      {
        "type": "tag",
        "name": "database"
      }, {
        "type": "tag",
        "name": "virtual"
      }
    ]
  }' \
 http://localhost:3081/tags
```

```ruby
require 'flapjack-diner'
Flapjack::Diner.base_uri('localhost:3081')

Flapjack::Diner.create_tags({
    :name => 'database'
  })

# or

Flapjack::Diner.create_tags({
    :name => 'database'
  }, {
    :name => 'virtual'
  })
```
