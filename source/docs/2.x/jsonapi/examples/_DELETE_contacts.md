```shell
curl -w 'response: %{http_code} \n' -X DELETE -H "Content-type: application/vnd.api+json; ext=bulk" -d \
 '{
    "data": [
      {
        "type": "contact",
        "id": "9313428a-3fcc-4444-8b68-8764252ca095"
      }, {
        "type": "contact",
        "id": "18ed5a56-f963-44c5-8663-cc201cebbae1"
      }
    ]
  }' \
 http://localhost:3081/contacts
```

```ruby
require 'flapjack-diner'
Flapjack::Diner.base_uri('localhost:3081')

Flapjack::Diner.delete_contacts(
  '9313428a-3fcc-4444-8b68-8764252ca095',
  '18ed5a56-f963-44c5-8663-cc201cebbae1'
)
```
