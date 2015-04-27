```shell
curl -w 'response: %{http_code} \n' -X PATCH -H "Content-type: application/vnd.api+json; ext=bulk" -d \
'{
  "data" : [
    {
      "id": "a1f041ab-304e-4d9c-9986-fb89added74c",
      "type": "medium",
      "interval": 90
    }, {
      "id": "50d1bf6b-422a-4134-ae1f-373f2ffde137",
      "type": "medium",
      "rollup_threshold": 5
    }
  ]
}' \
 'http://localhost:3081/media
```

```ruby
require 'flapjack-diner'
Flapjack::Diner.base_uri('localhost:3081')

Flapjack::Diner.update_media(
  {:id => 'a1f041ab-304e-4d9c-9986-fb89added74c', :interval => 90},
  {:id => '50d1bf6b-422a-4134-ae1f-373f2ffde137', :rollup_threshold => 5}
)
```
