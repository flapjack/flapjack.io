```shell
curl -w 'response: %{http_code} \n' -X DELETE \
 http://localhost:3081/rules/46127df9-c858-41b3-a4c3-06549efeadf8
```

```ruby
Flapjack::Diner.delete_rules(
  '46127df9-c858-41b3-a4c3-06549efeadf8'
)
```
