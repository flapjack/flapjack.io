```shell
curl -w 'response: %{http_code} \n' -X POST -H "Content-type: application/vnd.api+json" -d \
 '{
    "data": {
        "type": "rule"
      }
  }' \
 http://localhost:3081/rules

# or

curl -w 'response: %{http_code} \n' -X POST -H "Content-type: application/vnd.api+json; ext=bulk" -d \
 '{
    "data": [
      {
        "type": "rule"
      }, {
        "type": "rule"
      }
    ]
  }' \
 http://localhost:3081/rules
```

```ruby
require 'flapjack-diner'
Flapjack::Diner.base_uri('localhost:3081')

Flapjack::Diner.create_rules({
  })

# or

Flapjack::Diner.create_rules({
  }, {
  })
```
