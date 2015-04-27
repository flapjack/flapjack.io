```shell
curl -w 'response: %{http_code} \n' -X PATCH -H "Content-type: application/vnd.api+json; ext=bulk" -d \
'{
  "data" : [
    {
      "id": "9313428a-3fcc-4444-8b68-8764252ca095",
      "type": "contact",
      "timezone": "UTC"
    }, {
      "id": "18ed5a56-f963-44c5-8663-cc201cebbae1",
      "type": "contact",
      "name": "Jane Smith"
    }
  ]
}' \
 'http://localhost:3081/contacts
```

```ruby
require 'flapjack-diner'
Flapjack::Diner.base_uri('localhost:3081')

Flapjack::Diner.update_contacts(
  {:id => '9313428a-3fcc-4444-8b68-8764252ca095', :timezone => 'UTC'},
  {:id => '18ed5a56-f963-44c5-8663-cc201cebbae1', :name => 'Jane Smith'}
)
```
