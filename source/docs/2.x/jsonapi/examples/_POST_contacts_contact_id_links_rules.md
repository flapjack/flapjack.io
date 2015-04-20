```shell
curl -w 'response: %{http_code} \n' -X POST -H "Content-type: application/vnd.api+json" -d \
 '{
    "data": [
      {
        "type": "rule",
        "id": "46127df9-c858-41b3-a4c3-06549efeadf8"
      }
    ]
  }' \
 http://localhost:3081/contacts/9313428a-3fcc-4444-8b68-8764252ca095/links/rules

# or

curl -w 'response: %{http_code} \n' -X POST -H "Content-type: application/vnd.api+json" -d \
 '{
    "data": [
      {
        "type": "rule",
        "id": "46127df9-c858-41b3-a4c3-06549efeadf8"
      }, {
        "type": "rule",
        "id": "b84351c4-455a-481e-bd50-cd680812ce6a"
      }
    ]
  }' \
 http://localhost:3081/contacts/9313428a-3fcc-4444-8b68-8764252ca095/links/rules
```

```ruby
Flapjack::Diner.create_contacts_link_rules(
  '9313428a-3fcc-4444-8b68-8764252ca095',
  '46127df9-c858-41b3-a4c3-06549efeadf8'
)

# or

Flapjack::Diner.create_contacts_link_rules(
  '9313428a-3fcc-4444-8b68-8764252ca095',
  '46127df9-c858-41b3-a4c3-06549efeadf8',
  'b84351c4-455a-481e-bd50-cd680812ce6a'
)
```