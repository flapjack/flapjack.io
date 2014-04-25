
# Media

The Medium resource has the following attributes:

Attribute | Type | Description
--- | --- | ---
type | String | `email`, `sms`, or `jabber`
address | String |
interval | Integer |
rollup_threshold | Integer |

## Create media for a contact

```shell
curl -w 'response: %{http_code} \n' -X POST -H "Content-Type: application/vnd.api+json" -d \
 '{
    "media": [
      {
        "type" : "email",
        "address" : "johns@example.com",
        "interval" : 120,
        "rollup_threshold" : 5
      }
    ]
  }' \
 http://localhost:3081/contacts/5/media
```

```ruby
require 'flapjack-diner'
Flapjack::Diner.base_uri('localhost:3081')

Flapjack::Diner.create_contact_media('5',
  {'type'             => 'email',
   'address'          => 'johns@example.com',
   'interval'         => 120,
   'rollup_threshold' => 5})
```

### HTTP Request

`POST /contacts/CONTACT_ID/media`

### Query Parameters

Parameter | Type | Description
--------- | ---- | -----------
media | Array[Medium] | An array of Medium resources to create.

### HTTP Return Codes

Return code | Description
--------- | -----------
201 | The submitted media resources were created successfully.
405 | **Error** The submitted media data was not sent with the JSONAPI MIME type `application/vnd.api+json`.
409 | **Error** Media with ids matching those submitted were found.
422 | **Error** The submitted media data did not conform to the provided specification.


## Get media

If no media ids are provided then all media resources will be returned; if media ids
are provided then only the media resources matching those ids will be returned.

NB: Ids for media resources are currently represented by a String
containing the id of the associated contact, an underscore and then the type
of the medium in question. This is for backwards compatibility, and is due to
some historical design decisions, but is likely to change when the data
handling code is reworked.

```shell
curl http://localhost:3081/media

# or
curl http://localhost:3081/media/1_email

# or
curl http://localhost:3081/media/21_jabber,22_jabber
```

```ruby
require 'flapjack-diner'
Flapjack::Diner.base_uri('localhost:3081')

Flapjack::Diner.media

# or
Flapjack::Diner.media('1_email')

# or
Flapjack::Diner.media('21_jabber', '22_jabber')
```

> The commands return JSON structured like this, which is broken up by Flapjack::Diner into its constituent hashes:

```json
{
  "media": [
    {
      "id": "21_sms",
      "type": "sms",
      "address": "0123456789",
      "interval": 300,
      "rollup_threshold": 5,
      "links": {
        "contacts": ["21"]
      }
    },
    {
      "id": "22_email",
      "type": "email",
      "address": "abcde@example.com",
      "interval": 180,
      "rollup_threshold": 4,
      "links": {
        "contacts": ["22"]
      }
    }
  ]
}
```

### HTTP Request

`GET /media`

**or**

`GET /media/ID[,ID,ID...]`

### Query Parameters

None.

### HTTP Return Codes

Return code | Description
--------- | -----------
200 | OK


## Update media

Update one or more attributes for one or more media resources.

```shell
curl -w 'response: %{http_code} \n' -X PATCH -H "Content-Type: application/json-patch+json" -d \
'[
  {"op"    : "replace",
   "path"  : "/media/0/address",
   "value" : "0123456789"},
  {"op"    : "replace",
   "path"  : "/media/0/interval",
   "value" : 10}
]' \
 'http://localhost:3081/media/21_sms'
```

```ruby
require 'flapjack-diner'
Flapjack::Diner.base_uri('localhost:3081')

Flapjack::Diner.update_media('21_sms',
  :address  => '0123456789',
  :interval => 10)
```

### HTTP Request

`PATCH /media/ID[,ID,ID...]`

### Query Parameters

Parameters sent for medium updates must form a valid [JSON Patch (RFC 6902)](http://tools.ietf.org/html/rfc6902) document. This is comprised of a bare JSON array of JSON-Patch operation objects, which have three members:

Parameter | Type | Description
--------- | ---- | -----------
op | String | may only be *replace*
path | String | "/media/0/ATTRIBUTE" (e.g. 'address')
value | -> | a value of the correct data type for the attribute in the path

### HTTP Return Codes

Return code | Description
--------- | -----------
204 | The submitted medium updates were made successfully. No content is returned.
404 | Media resources could not be found for one or more of the provided ids. No media resources were altered by this request.
405 | **Error** The submitted media data was not sent with the JSON-Patch MIME type `application/json-patch+json`.


## Delete media

Delete one or more media resources.

```shell
curl -w 'response: %{http_code} \n' -X DELETE \
  'http://localhost:3081/media/11_email'

# or
curl -w 'response: %{http_code} \n' -X DELETE \
  'http://localhost:3081/media/31_jabber,32_jabber'
```

```ruby
require 'flapjack-diner'
Flapjack::Diner.base_uri('localhost:3081')

Flapjack::Diner.delete_media('11_email')

# or
Flapjack::Diner.delete_media('31_jabber', '32_jabber')
```

### HTTP Request

`DELETE /media/ID[,ID,ID...]`

### Query Parameters

None.

### HTTP Return Codes

Return code | Description
--------- | -----------
204 | The medium/media resources were deleted
404 | Media resources could not be found for one or more of the provided ids. No media resources were deleted by this request.
