```shell
curl -w 'response: %{http_code} \n' -X POST -H "Content-type: application/vnd.api+json" -d \
 '{
    "data": [
      {
        "type": "medium",
        "id": "a1f041ab-304e-4d9c-9986-fb89added74c"
      }
    ]
  }' \
 http://localhost:3081/rules/46127df9-c858-41b3-a4c3-06549efeadf8/links/media

# or

curl -w 'response: %{http_code} \n' -X POST -H "Content-type: application/vnd.api+json" -d \
 '{
    "data": [
      {
        "type": "medium",
        "id": "a1f041ab-304e-4d9c-9986-fb89added74c"
      }, {
        "type": "medium",
        "id": "50d1bf6b-422a-4134-ae1f-373f2ffde137"
      }
    ]
  }' \
 http://localhost:3081/rules/46127df9-c858-41b3-a4c3-06549efeadf8/links/media
```

```ruby
require 'flapjack-diner'
Flapjack::Diner.base_uri('localhost:3081')

Flapjack::Diner.create_rules_link_media(
  '46127df9-c858-41b3-a4c3-06549efeadf8',
  'a1f041ab-304e-4d9c-9986-fb89added74c'
)

# or

Flapjack::Diner.create_rules_link_media(
  '46127df9-c858-41b3-a4c3-06549efeadf8',
  'a1f041ab-304e-4d9c-9986-fb89added74c',
  '50d1bf6b-422a-4134-ae1f-373f2ffde137'
)
```
