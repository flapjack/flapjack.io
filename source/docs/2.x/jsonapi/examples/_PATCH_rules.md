```shell
curl -w 'response: %{http_code} \n' -X PATCH -H "Content-type: application/vnd.api+json; ext=bulk" -d \
'{
  "data" : [
    {
      "id": "46127df9-c858-41b3-a4c3-06549efeadf8",
      "type": "rule"
      "links": {
        "contact": {
          "linkage": {
            "type": "contact", "id": "9313428a-3fcc-4444-8b68-8764252ca095"
          }
        }
      }
    }, {
      "id": "b84351c4-455a-481e-bd50-cd680812ce6a",
      "type": "rule"
      "links": {
        "contact": null
      }
    }
  ]
}' \
 'http://localhost:3081/rules
```

```ruby
require 'flapjack-diner'
Flapjack::Diner.base_uri('localhost:3081')

Flapjack::Diner.update_rules(
  {:id => '46127df9-c858-41b3-a4c3-06549efeadf8', :contact => '9313428a-3fcc-4444-8b68-8764252ca095'},
  {:id => 'b84351c4-455a-481e-bd50-cd680812ce6a', :contact => nil}
)
```
