```shell
curl -w 'response: %{http_code} \n' -X DELETE -H "Content-type: application/vnd.api+json" -d \
 '{
    "data": [
      {
        "type": "rule",
        "id": "46127df9-c858-41b3-a4c3-06549efeadf8"
      }
    ]
  }' \
 http://localhost:3081/tags/database/links/rules

# or

curl -w 'response: %{http_code} \n' -X DELETE -H "Content-type: application/vnd.api+json" -d \
 '{
    "data": [
      {
        "type": "rule",
        "id": "46127df9-c858-41b3-a4c3-06549efeadf8"
      }, {
        "type": "rule",
        "id": "b84351c4-455a-481e-bd50-cd680812ce6a"
      }
    ]
  }' \
 http://localhost:3081/tags/database/links/rules
```

```ruby
Flapjack::Diner.delete_tags_link_rules(
  'database',
  '46127df9-c858-41b3-a4c3-06549efeadf8'
)

# or

Flapjack::Diner.delete_tags_link_rules(
  'database',
  '46127df9-c858-41b3-a4c3-06549efeadf8',
  'b84351c4-455a-481e-bd50-cd680812ce6a'
)
```
