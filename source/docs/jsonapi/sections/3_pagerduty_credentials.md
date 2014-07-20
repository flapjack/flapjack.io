
# PagerDuty credentials

The PagerDuty resource has the following attributes:

Attribute | Type | Description
--- | --- | ---
service_key | String |
subdomain | String |
username | String |
password | String |


## Create PagerDuty credentials for a contact

```shell
curl -w 'response: %{http_code} \n' -X POST -H "Content-Type: application/vnd.api+json" -d \
 '{
    "pagerduty_credentials": [
      {
        "service_key" : "567890123456789012345678",
        "subdomain" : "eggs",
        "username" : "flapjack",
        "password" : "tomato"
      }
    ]
  }' \
 http://localhost:3081/contacts/5/pagerduty_credentials
```

```ruby
require 'flapjack-diner'
Flapjack::Diner.base_uri('localhost:3081')

Flapjack::Diner.create_contact_pagerduty_credentials(
  '5',
  {
    'service_key' => '567890123456789012345678',
    'subdomain'   => 'eggs',
    'username'    => 'flapjack',
    'password'    => 'tomato'
  }
)
```

### HTTP Request

`POST /contacts/CONTACT_ID/pagerduty_credentials`

### Query Parameters

Parameter | Type | Description
--------- | ---- | -----------
pagerduty_credentials | Array[PagerDuty] | An array of PagerDuty resources to create.

### HTTP Return Codes

Return code | Description
--------- | -----------
201 | The submitted PagerDuty credentials resources were created successfully.
405 | **Error** The submitted PagerDuty credentials data was not sent with the JSONAPI MIME type `application/vnd.api+json`.
422 | **Error** The submitted PagerDuty credentials data did not conform to the provided specification.


## Get PagerDuty credentials

If no contact ids are provided then all PagerDuty credentials resources will be returned; if contact ids
are provided then only the PagerDuty credentials resources matching those ids will be returned.

```shell
curl http://localhost:3081/pagerduty_credentials

# or
curl http://localhost:3081/pagerduty_credentials/1

# or
curl http://localhost:3081/pagerduty_credentials/21,22
```

```ruby
require 'flapjack-diner'
Flapjack::Diner.base_uri('localhost:3081')

Flapjack::Diner.pagerduty_credentials

# or
Flapjack::Diner.pagerduty_credentials('1')

# or
Flapjack::Diner.pagerduty_credentials('21', '22')
```

> The commands return JSON structured like this, which is broken up by Flapjack::Diner into its constituent hashes:

```json
{
  "pagerduty_credentials": [
    {
      "service_key" : "567890123456789012345678",
      "subdomain" : "eggs",
      "username" : "flapjack",
      "password" : "tomato",
      "links": {
        "contacts": ["21"]
      }
    },
    {
      "service_key" : "456789012345678901234567",
      "subdomain" : "spam",
      "username" : "waffle",
      "password" : "eggplant",
      "links": {
        "contacts": ["22"]
      }
    }
  ]
}
```

### HTTP Request

`GET /pagerduty_credentials`

**or**

`GET /pagerduty_credentials/CONTACT_ID[,CONTACT_ID,CONTACT_ID...]`

### Query Parameters

None.

### HTTP Return Codes

Return code | Description
--------- | -----------
200 | OK


## Update PagerDuty credentials

Update one or more attributes for one or more PagerDuty credentials resources.

```shell
curl -w 'response: %{http_code} \n' -X PATCH -H "Content-Type: application/json-patch+json" -d \
'[
  {"op"    : "replace",
   "path"  : "/pagerduty_credentials/0/username",
   "value" : "genius"},
  {"op"    : "replace",
   "path"  : "/pagerduty_credentials/0/password",
   "value" : "ideas"}
]' \
 'http://localhost:3081/pagerduty_credentials/21s'
```

```ruby
require 'flapjack-diner'
Flapjack::Diner.base_uri('localhost:3081')

Flapjack::Diner.update_pagerduty_credentials(
  '21',
  :username => 'genius',
  :password => 'ideas'
)
```

### HTTP Request

`PATCH /pagerduty_credentials/CONTACT_ID[,CONTACT_ID,CONTACT_ID...]`

### Query Parameters

Parameters sent for PagerDuty credentials updates must form a valid [JSON Patch (RFC 6902)](http://tools.ietf.org/html/rfc6902) document. This is comprised of a bare JSON array of JSON-Patch operation objects, which have three members:

Parameter | Type | Description
--------- | ---- | -----------
op | String | may only be *replace*
path | String | "/pagerduty_credentials/0/ATTRIBUTE" (e.g. 'username')
value | -> | a value of the correct data type for the attribute in the path

### HTTP Return Codes

Return code | Description
--------- | -----------
204 | The submitted PagerDuty credentials updates were made successfully. No content is returned.
404 | PagerDuty credentials resources could not be found for one or more of the provided contact ids. No PagerDuty credentials resources were altered by this request.
405 | **Error** The submitted PagerDuty credentials data was not sent with the JSON-Patch MIME type `application/json-patch+json`.


## Delete PagerDuty credentials

Delete one or more PagerDuty credentials resources.

```shell
curl -w 'response: %{http_code} \n' -X DELETE \
  'http://localhost:3081/pagerduty_credentials/11'

# or
curl -w 'response: %{http_code} \n' -X DELETE \
  'http://localhost:3081/pagerduty_credentials/31,32'
```

```ruby
require 'flapjack-diner'
Flapjack::Diner.base_uri('localhost:3081')

Flapjack::Diner.delete_pagerduty_credentials('11')

# or
Flapjack::Diner.delete_pagerduty_credentials('31', '32')
```

### HTTP Request

`DELETE /pagerduty_credentials/CONTACT_ID[,CONTACT_ID,CONTACT_ID...]`

### Query Parameters

None.

### HTTP Return Codes

Return code | Description
--------- | -----------
204 | The PagerDuty credentials resources were deleted
404 | PagerDuty credentials could not be found for one or more of the provided contact ids. No PagerDuty credentials were deleted by this request.
