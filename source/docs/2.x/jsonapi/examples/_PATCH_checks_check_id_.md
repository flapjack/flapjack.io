```shell
curl -w 'response: %{http_code} \n' -X PATCH -H "Content-type: application/vnd.api+json" -d \
'{
  "data" : {
    "id": "2d6e8006-e220-4962-ab0f-248978abdc72",
    "type": "check",
    "name": "example.com:SSH"
  }
}' \
 'http://localhost:3081/checks/2d6e8006-e220-4962-ab0f-248978abdc72'

# or, replacing related data:

curl -w 'response: %{http_code} \n' -X PATCH -H "Content-type: application/vnd.api+json" -d \
'{
  "data" : {
    "id": "2d6e8006-e220-4962-ab0f-248978abdc72",
    "type": "check",
    "links": {
      "tags": {
        "linkage": [
          {"type": "tag", "id": "virtual"}
        ]
      }
    }
  }
}' \
 'http://localhost:3081/checks/2d6e8006-e220-4962-ab0f-248978abdc72'
```

```ruby
require 'flapjack-diner'
Flapjack::Diner.base_uri('localhost:3081')

Flapjack::Diner.update_checks(
  {:id => "2d6e8006-e220-4962-ab0f-248978abdc72", :name => 'example.com:SSH'}
)

# or, replacing related data:

Flapjack::Diner.update_checks(
  {:id => "2d6e8006-e220-4962-ab0f-248978abdc72", :tags => ['virtual']}
)
```
