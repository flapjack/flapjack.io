```shell
curl -w 'response: %{http_code} \n' -X PATCH -H "Content-type: application/vnd.api+json" -d \
'{
  "data" : {
    "id": "a1f041ab-304e-4d9c-9986-fb89added74c",
    "type": "medium",
    "interval": 90
  }
}' \
 'http://localhost:3081/media/a1f041ab-304e-4d9c-9986-fb89added74c'
```

```ruby
require 'flapjack-diner'
Flapjack::Diner.base_uri('localhost:3081')

Flapjack::Diner.update_media(
  {:id => 'a1f041ab-304e-4d9c-9986-fb89added74c', :interval => 90}
)
```
