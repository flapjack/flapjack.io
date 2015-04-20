```shell
curl -w 'response: %{http_code} \n' -X DELETE -H "Content-type: application/vnd.api+json" -d \
 '{
    "data": [
      {
        "type": "medium",
        "id": "a1f041ab-304e-4d9c-9986-fb89added74c"
      }
    ]
  }' \
 http://localhost:3081/contacts/9313428a-3fcc-4444-8b68-8764252ca095/links/media

# or

curl -w 'response: %{http_code} \n' -X DELETE -H "Content-type: application/vnd.api+json" -d \
 '{
    "data": [
      {
        "type": "medium",
        "id": "a1f041ab-304e-4d9c-9986-fb89added74c"
      }, {
        "type": "medium",
        "id": "50d1bf6b-422a-4134-ae1f-373f2ffde137"
      }
    ]
  }' \
 http://localhost:3081/contacts/9313428a-3fcc-4444-8b68-8764252ca095/links/media
```

```ruby
Flapjack::Diner.delete_contacts_link_media(
  '9313428a-3fcc-4444-8b68-8764252ca095',
  'a1f041ab-304e-4d9c-9986-fb89added74c'
)

# or

Flapjack::Diner.delete_contacts_link_media(
  '9313428a-3fcc-4444-8b68-8764252ca095',
  'a1f041ab-304e-4d9c-9986-fb89added74c',
  '50d1bf6b-422a-4134-ae1f-373f2ffde137'
)
```
