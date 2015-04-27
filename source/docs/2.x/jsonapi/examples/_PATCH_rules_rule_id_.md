```shell
curl -w 'response: %{http_code} \n' -X PATCH -H "Content-type: application/vnd.api+json" -d \
'{
  "data" : {
    "id": "46127df9-c858-41b3-a4c3-06549efeadf8",
    "type": "rule"
    "links": {
      "contact": {
        "linkage": {
          "type": "contact", "id": "9313428a-3fcc-4444-8b68-8764252ca095"
        }
      }
    }
  }
}' \
 'http://localhost:3081/rules/46127df9-c858-41b3-a4c3-06549efeadf8'
```

```ruby
require 'flapjack-diner'
Flapjack::Diner.base_uri('localhost:3081')

Flapjack::Diner.update_rules(
  {:id => '46127df9-c858-41b3-a4c3-06549efeadf8', :contact => '9313428a-3fcc-4444-8b68-8764252ca095'}
)

# or

Flapjack::Diner.update_rules(
  {:id => '46127df9-c858-41b3-a4c3-06549efeadf8', :contact => nil}
)

```
