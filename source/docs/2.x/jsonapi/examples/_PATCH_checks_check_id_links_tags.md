```shell
curl -w 'response: %{http_code} \n' -X PATCH -H "Content-type: application/vnd.api+json" -d \
 '{
    "data": [
      {
        "type": "tag",
        "id": "database"
      }
    ]
  }' \
 http://localhost:3081/checks/2d6e8006-e220-4962-ab0f-248978abdc72/links/tags

# or

curl -w 'response: %{http_code} \n' -X PATCH -H "Content-type: application/vnd.api+json" -d \
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
 http://localhost:3081/checks/2d6e8006-e220-4962-ab0f-248978abdc72/links/tags
```

```ruby
require 'flapjack-diner'
Flapjack::Diner.base_uri('localhost:3081')

Flapjack::Diner.update_checks_link_tags('2d6e8006-e220-4962-ab0f-248978abdc72',
  'database')

# or

Flapjack::Diner.update_checks_link_tags('2d6e8006-e220-4962-ab0f-248978abdc72',
  'database', 'virtual')
```
