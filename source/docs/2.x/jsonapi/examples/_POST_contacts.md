```shell
curl -w 'response: %{http_code} \n' -X POST -H "Content-type: application/vnd.api+json" -d \
 '{
    "data": {
        "type": "contact",
        "name": "John Smith",
        "timezone": "Australia/Darwin"
      }
  }' \
 http://localhost:3081/contacts

# or

curl -w 'response: %{http_code} \n' -X POST -H "Content-type: application/vnd.api+json; ext=bulk" -d \
 '{
    "data": [
      {
        "type": "contact",
        "name": "John Smith",
        "timezone": "Australia/Darwin"
      }, {
        "type": "contact",
        "name": "Jane Jones",
        "timezone": "UTC"
      }
    ]
  }' \
 http://localhost:3081/contacts
```

```ruby
Flapjack::Diner.create_contacts({
    :name => 'John Smith', :timezone => 'Australia/Darwin'
  })

# or

Flapjack::Diner.create_contacts({
    :name => 'John Smith', :timezone => 'Australia/Darwin'
  }, {
    :name => 'Jane Jones', :timezone => 'UTC'
  })
```