# [JSON API](jsonapi) :: Media

<ul>
  <li><a href="#get_contacts_id_media">GET /contacts/CONTACT_ID/media</a></li>
  <li><a href="#get_contacts_id_media_media">GET /contacts/CONTACT_ID/media/MEDIA</a></li>
  <li><a href="#put_contacts_id_media_media">PUT, DELETE /contacts/CONTACT_ID/media/MEDIA</a></li>
</ul>

<a id="get_contacts_id_media">&nbsp;</a>
### GET /contacts/CONTACT_ID/media

Returns the media of a contact.

Includes media type, address, interval, and rollup threshold.

**Example**
```bash
curl -w 'response: %{http_code} \n' \
 http://localhost:3081/contacts/21/media
```

<a id="get_contacts_id_media_media">&nbsp;</a>
### GET /contacts/CONTACT_ID/media/MEDIA

Returns the specified media of a contact.


<a id="put_contacts_id_media_media">&nbsp;</a>
### PUT, DELETE /contacts/CONTACT_ID/media/MEDIA

Creates or updates (PUT) or deletes (DELETE) a media of a contact

**Example 1 - PUT**
```bash
curl -w 'response: %{http_code} \n' -X PUT -H "Content-type: application/json" -d \
 '{
    "address": "dmitri@example.com",
    "interval": 900,
    "rollup_threshold": 3
  }' \
 http://localhost:3081/contacts/21/media/email
```
**Response** Status: 200 OK
```json
{
  "address": "dmitri@example.com",
  "interval": 900,
  "rollup_threshold": 3
}
```

**Example 2 - DELETE**
```bash
curl -w 'response: %{http_code} \n' -X DELETE \
 http://localhost:3081/contacts/21/media/pagerduty
```
**Response** Status: 204 OK


**Notes:**
* any missing attributes in an update will remove those attributes (eg interval)
* address can't be removed and will cause a validation error

