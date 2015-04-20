```shell
curl -w 'response: %{http_code} \n' -X DELETE \
 http://localhost:3081/media/a1f041ab-304e-4d9c-9986-fb89added74c
```

```ruby
Flapjack::Diner.delete_media(
  'a1f041ab-304e-4d9c-9986-fb89added74c'
)
```
