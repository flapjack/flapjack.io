```shell
curl -w 'response: %{http_code} \n' -X PATCH -H "Content-type: application/vnd.api+json" -d \
 '{
    "data": {
      "type": "contact",
      "id": "9313428a-3fcc-4444-8b68-8764252ca095"
      }
    ]
  }' \
 http://localhost:3081/media/a1f041ab-304e-4d9c-9986-fb89added74c/links/contact

# or

curl -w 'response: %{http_code} \n' -X PATCH -H "Content-type: application/vnd.api+json" -d \
 '{
    "data": null
  }' \
 http://localhost:3081/media/a1f041ab-304e-4d9c-9986-fb89added74c/links/contact
```

```ruby
require 'flapjack-diner'
Flapjack::Diner.base_uri('localhost:3081')

Flapjack::Diner.update_media_link_contact(
  'a1f041ab-304e-4d9c-9986-fb89added74c'
  '9313428a-3fcc-4444-8b68-8764252ca095',
)

# or

Flapjack::Diner.update_media_link_contact(
  'a1f041ab-304e-4d9c-9986-fb89added74c',
  nil
)
```
