```shell
curl -w 'response: %{http_code} \n' -X POST -H "Content-type: application/vnd.api+json" -d \
 '{
    "data": [
      {
        "type": "rule",
        "id": "46127df9-c858-41b3-a4c3-06549efeadf8"
      }
    ]
  }' \
 http://localhost:3081/media/f323c498-0cb8-43fe-868e-908a5d683c6d/links/rules

# or

curl -w 'response: %{http_code} \n' -X POST -H "Content-type: application/vnd.api+json" -d \
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
 http://localhost:3081/media/f323c498-0cb8-43fe-868e-908a5d683c6d/links/rules

```

```ruby
Flapjack::Diner.create_media_link_rules(
  'f323c498-0cb8-43fe-868e-908a5d683c6d',
  '46127df9-c858-41b3-a4c3-06549efeadf8'
)

# or

Flapjack::Diner.create_media_link_rules(
  'f323c498-0cb8-43fe-868e-908a5d683c6d',
  '46127df9-c858-41b3-a4c3-06549efeadf8',
  'b84351c4-455a-481e-bd50-cd680812ce6a'
)
```