```shell
curl -w 'response: %{http_code} \n' -X POST -H "Content-type: application/vnd.api+json" -d \
 '{
    "data": {
        "type": "check",
        "name": "example.com:HTTP",
        "enabled": true
      }
  }' \
 http://localhost:3081/checks

# or

curl -w 'response: %{http_code} \n' -X POST -H "Content-type: application/vnd.api+json; ext=bulk" -d \
 '{
    "data": [
      {
        "type": "check",
        "name": "example.com:HTTP",
        "enabled": true
      }, {
        "type": "check",
        "name": "example_2.com:HTTP",
        "enabled": true
      }
    ]
  }' \
 http://localhost:3081/checks
```

```ruby
Flapjack::Diner.create_checks({
    :name => 'example.com:HTTP', :enabled => true
  })

# or

Flapjack::Diner.create_checks({
    :name => 'example.com:HTTP', :enabled => true
  }, {
    :name => 'example_2.com:HTTP', :enabled => true
  })
```