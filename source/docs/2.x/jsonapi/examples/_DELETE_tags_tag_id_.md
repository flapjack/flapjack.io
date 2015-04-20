```shell
curl -w 'response: %{http_code} \n' -X DELETE \
 http://localhost:3081/tags/database
```

```ruby
Flapjack::Diner.delete_tags('database')
```
