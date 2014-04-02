
# Media

The Medium resource has the following attributes:

Attribute | Type | Description
--- | --- | ---
type | String | `email`, `sms`, or `jabber`
address | String |
interval | Integer |
rollup_threshold | Integer |

TODO 'pagerduty' media type


## Create media for a contact

```shell
```

```ruby
require 'flapjack-diner'
Flapjack::Diner.base_uri('localhost:3081')

```

### HTTP Request

    POST http://localhost:3081/contacts/CONTACT_ID/media<br>
    Content-Type: application/vnd.api+json<br>
    Accept: application/vnd.api+json

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

If no media ids are provided then all contacts will be returned; if media ids
are provided then only the media resource matching those ids will be returned.

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

### HTTP Request

    GET http://localhost:3081/media<br>
    Accept: application/vnd.api+json

**or**

    GET http://localhost:3081/media/ID[,ID,ID...]<br>
    Accept: application/vnd.api+json

### Query Parameters

None.


## Update media

Update one or more media resources.

```shell
```

```ruby
require 'flapjack-diner'
Flapjack::Diner.base_uri('localhost:3081')

```

### HTTP Request

    PATCH http://localhost:3081/contacts/ID[,ID,ID...]<br>
    Content-Type: application/vnd.api+json<br>
    Accept: application/vnd.api+json

### Query Parameters

Parameters sent for medium updates must form a valid [JSON Patch (RFC 6902)](http://tools.ietf.org/html/rfc6902) document. This is comprised of a bare JSON array of JSON-Patch operation objects, which have three members:

Parameter | Type | Description
--------- | ---- | -----------
op | String | may only be *replace*
path | String | "/media/0/ATTRIBUTE" (e.g. 'address')
value | -> | a value of the correct data type for the attribute in the path


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

Flapjack::Diner.delete_media!('11_email')
# or
Flapjack::Diner.delete_media!('31_jabber', '32_jabber')
```

### HTTP Request

    DELETE http://localhost:3081/media/ID[,ID,ID...]<br>

### Query Parameters

Return code | Description
--------- | -----------
204 | The medium/media resources were deleted
404 | Media resources could not be found for one or more of the provided ids. No media resources were deleted by this request.
