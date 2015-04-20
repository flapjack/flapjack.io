```shell
curl -w 'response: %{http_code} \n' -X DELETE -H "Content-type: application/vnd.api+json; ext=bulk" -d \
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
 http://localhost:3081/rules
```

```ruby
Flapjack::Diner.delete_rules(
  '46127df9-c858-41b3-a4c3-06549efeadf8',
  'b84351c4-455a-481e-bd50-cd680812ce6a'
)
```
