```shell
curl -w 'response: %{http_code} \n' -X DELETE -H "Content-type: application/vnd.api+json; ext=bulk" -d \
 '{
    "data": [
      {
        "type": "check",
        "id": "2d6e8006-e220-4962-ab0f-248978abdc72"
      }, {
        "type": "check",
        "id": "2440cd0f-1b79-4cc4-bed1-8dcdeaf59f81"
      }
    ]
  }' \
 http://localhost:3081/checks
```

```ruby
Flapjack::Diner.delete_checks(
  '2d6e8006-e220-4962-ab0f-248978abdc72',
  '2440cd0f-1b79-4cc4-bed1-8dcdeaf59f81'
)
```
