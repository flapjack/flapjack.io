```shell
curl -w 'response: %{http_code} \n' -X POST -H "Content-type: application/vnd.api+json" -d \
 '{
    "data": {
        "type": "medium",
        "transport": "email",
        "address", "johns@example.com",
        "interval": 30,
        "rollup_threshold": 5
      }
  }' \
 http://localhost:3081/media

# or

curl -w 'response: %{http_code} \n' -X POST -H "Content-type: application/vnd.api+json; ext=bulk" -d \
 '{
    "data": [
      {
        "type": "medium",
        "transport": "email",
        "address", "johns@example.com",
        "interval": 30,
        "rollup_threshold": 5
      }, {
        "type": "medium",
        "transport": "sms",
        "address", "+61412345678",
        "interval": 60,
        "rollup_threshold": 2
      }
    ]
  }' \
 http://localhost:3081/media
```

```ruby
require 'flapjack-diner'
Flapjack::Diner.base_uri('localhost:3081')

Flapjack::Diner.create_media({
    :transport => 'email', :address => 'johns@example.com',
    :interval => 30, :rollup_threshold => 5
  })

# or

Flapjack::Diner.create_media({
    :transport => 'email', :address => 'johns@example.com',
    :interval => 30, :rollup_threshold => 5
  }, {
    :transport => 'sms', :address => '+61412345678',
    :interval => 60, :rollup_threshold => 2
  })
```
