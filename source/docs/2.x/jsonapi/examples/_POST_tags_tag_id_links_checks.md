```shell
curl -w 'response: %{http_code} \n' -X POST -H "Content-type: application/vnd.api+json" -d \
 '{
    "data": [
      {
        "type": "check",
        "id": "2d6e8006-e220-4962-ab0f-248978abdc72"
      }
    ]
  }' \
 http://localhost:3081/tags/database/links/checks

# or

curl -w 'response: %{http_code} \n' -X POST -H "Content-type: application/vnd.api+json" -d \
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
 http://localhost:3081/tags/database/links/checks
```

```ruby
Flapjack::Diner.create_tags_link_checks(
  'database',
  '2d6e8006-e220-4962-ab0f-248978abdc72'
)

# or

Flapjack::Diner.create_tags_link_checks(
  'database',
  '2d6e8006-e220-4962-ab0f-248978abdc72',
  '2440cd0f-1b79-4cc4-bed1-8dcdeaf59f81'
)
```