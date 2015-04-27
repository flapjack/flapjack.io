```shell
curl -w 'response: %{http_code} \n' -X PATCH -H "Content-type: application/vnd.api+json; ext=bulk" -d \
'{
  "data" : [
    {
      "id": "2d6e8006-e220-4962-ab0f-248978abdc72",
      "type": "check",
      "name": "example.com:SSH",
      "links": {
        "tags": {
          "linkage": [
            {"type": "tag", "id": "virtual"}
          ]
        }
      }
    }, {
      "id": "2440cd0f-1b79-4cc4-bed1-8dcdeaf59f81",
      "type": "check",
      "enabled": false
    }
  ]
}' \
 'http://localhost:3081/checks
```

```ruby
require 'flapjack-diner'
Flapjack::Diner.base_uri('localhost:3081')

Flapjack::Diner.update_checks(
  {:id => '2d6e8006-e220-4962-ab0f-248978abdc72', :name => 'example.com:SSH',
   :tags => ['virtual']},
  {:id => '2440cd0f-1b79-4cc4-bed1-8dcdeaf59f81', :enabled => false}
)
```
