```shell
curl -w 'response: %{http_code} \n' -X POST -H "Content-type: application/vnd.api+json" -d \
 '{
    "data": [
      {
        "type": "tag",
        "id": "database"
      }
    ]
  }' \
 http://localhost:3081/rules/46127df9-c858-41b3-a4c3-06549efeadf8/links/tags

# or

curl -w 'response: %{http_code} \n' -X POST -H "Content-type: application/vnd.api+json" -d \
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
 http://localhost:3081/rules/46127df9-c858-41b3-a4c3-06549efeadf8/links/tags
```

```ruby
require 'flapjack-diner'
Flapjack::Diner.base_uri('localhost:3081')

Flapjack::Diner.create_rules_link_tags(
  '46127df9-c858-41b3-a4c3-06549efeadf8',
  'database'
)

# or

Flapjack::Diner.create_rules_link_tags(
  '46127df9-c858-41b3-a4c3-06549efeadf8',
  'database', 'virtual'
)
```
