# [JSON API](jsonapi) :: Miscellaneous

## Endpoints

<ul>
  <li><a href="#post_contacts_atomic">POST /contacts_atomic</a></li>
  <li><a href="#get_contacts_id_timezone">GET /contacts/CONTACT_ID/timezone</a></li>
  <li><a href="#put_contacts_id_timezone">PUT, DELETE /contacts/CONTACT_ID/timezone</a></li>
  <li><a href="#get_contacts_id_tags">GET /contacts/CONTACT_ID/tags</a></li>
  <li><a href="#post_contacts_id_tags">POST /contacts/CONTACT_ID/tags</a></li>
  <li><a href="#delete_contacts_id_tags">DELETE /contacts/CONTACT_ID/tags</a></li>
  <li><a href="#get_contacts_id_entitytags">GET /contacts/CONTACT_ID/entity_tags</a></li>
  <li><a href="#post_contacts_id_entitytags">POST /contacts/CONTACT_ID/entity_tags</a></li>
  <li><a href="#delete_contacts_id_entitytags">DELETE /contacts/CONTACT_ID/entity_tags</a></li>
</ul>

<a id="post_contacts_atomic">&nbsp;</a>
### POST /contacts_atomic

**Deprecated** - use <a href="jsonapi-contacts#post_contacts">POST /contacts</a> instead.

Overwrite all contacts in flapjack. Any existing contacts not found in the supplied JSON payload will be deleted, then newly supplied contacts created, and existing contacts updated.

("atomic" - as in "nuclear").

Uses the same JSON format as <a href="jsonapi-contacts#post_contacts">POST /contacts</a>, however ID is always required.

**Example**
```bash
curl -w 'response: %{http_code} \n' -X POST -H "Content-type: application/json" -d \
 '{
    "contacts": [
      {
        "id": "21",
        "first_name": "Ada",
        "last_name": "Lovelace",
        "email": "ada@example.com",
        "media": {
          "sms": {
            "address": "+61412345678",
            "interval": "3600",
            "rollup_threshold": "5"
          },
          "email": {
            "address": "ada@example.com",
            "interval": "7200",
            "rollup_threshold": null
          }
        },
        "tags": [
          "legend",
          "first computer programmer"
        ]
      }
    ]
  }' \
 http://localhost:3081/contacts
```
**Response** Status: 204 No Content


<a id="get_contacts_id_timezone">&nbsp;</a>
### GET /contacts/CONTACT_ID/timezone

Returns the timezone of a contact.

**Example**
```bash
curl -w 'response: %{http_code} \n' http://localhost:3081/contacts/21/timezone
```

**Response** Status: 200 OK
```json
{
  "timezone": "Australia/Broken_Hill"
}
```
FIXME: too much repetition to have the response include the key name "timezone"? Perhaps just return a string?

<a id="put_contacts_id_timezone">&nbsp;</a>
### PUT, DELETE /contacts/CONTACT_ID/timezone

Sets (PUT) or deletes (DELETE) the timezone of a contact.

**Example**
```bash
curl -w 'response: %{http_code} \n' -X PUT -H "Content-type: application/json" -d \
 '{
    "timezone": "Australia/Broken_Hill"
  }' \
 http://localhost:3081/contacts/21/timezone
```

**Response** Status: 200 OK
```json
{
  "timezone": "Australia/Broken_Hill"
}
```

**Notes:**
* the timezone string must be one defined in the tzinfo database, see: http://www.twinsun.com/tz/tz-link.htm, http://tzinfo.rubyforge.org/doc/



<a name="get_contacts_id_tags">&nbsp;</a>
### GET /contacts/CONTACT_ID/tags

Gets the tags for a contact.

**Example**
```bash
curl http://localhost:3081/contacts/21/tags
```
**Response** Status: 200 OK
```json
{
  "tags": ["user", "admin"]
}
```

<a name="post_contacts_id_tags">&nbsp;</a>
### POST /contacts/CONTACT_ID/tags

Add tags to a contact.

**Example 1 - JSON params**
```bash
curl -w 'response: %{http_code} \n' -X POST -H "Content-type: application/json" -d \
 '{
    "tags": ["admin", "user"]
  }' \
 http://localhost:3081/contacts/21/tags
```

**Example 2 - URL params**
```bash
curl -w 'response: %{http_code} \n' -X POST \
 'http://localhost:3081/contacts/21/tags?tags[]=admin&tags[]=user'
```

**Response** Status: 200 OK
```json
{
  "tags": ["user", "admin"]
}
```

<a name="delete_contacts_id_tags">&nbsp;</a>
### DELETE /contacts/CONTACT_ID/tags

Delete tags from a contact.

**Example 1 - JSON params**
```bash
curl -w 'response: %{http_code} \n' -X DELETE -H "Content-type: application/json" -d \
 '{
    "tags": ["admin", "user"]
  }' \
 http://localhost:3081/contacts/21/tags
```

**Example 2 - URL params**
```bash
curl -w 'response: %{http_code} \n' -X DELETE \
 'http://localhost:3081/contacts/21/tags?tags[]=admin&tags[]=user'
```

**Response** Status: 204 No Content

<a name="get_contacts_id_entitytags">&nbsp;</a>
### GET /contacts/CONTACT_ID/entity_tags

Gets the tags for all entities linked to a contact.

**Example**
```bash
curl http://localhost:3081/contacts/21/entity_tags
```
**Response** Status: 200 OK
```json
{"foo-app-01.example.com" : ["example", "app"],
 "foo-app-02.example.com" : ["example", "database"]}
```

<a name="post_contacts_id_entitytags">&nbsp;</a>
### POST /contacts/CONTACT_ID/entity_tags

Add tags to entities linked to a contact.

**Example 1 - JSON params**
```bash
curl -w 'response: %{http_code} \n' -X POST -H "Content-type: application/json" -d \
 '{
    "entity": {"foo-app-01.example.com" : ["decommission", "unneeded"],
               "foo-app-02.example.com" : ["upgrade"]}
  }' \
 http://localhost:3081/contacts/21/entity_tags
```
**Example 2 - URL params**
```bash
curl -w 'response: %{http_code} \n' -X POST \
 'http://localhost:3081/contacts/21/entity_tags?entity[foo-app-01.example.com]=decommission&entity[foo-app-01.example.com]=unneeded&entity[foo-app-02.example.com]=upgrade'
```
**Response** Status: 200 OK
```json
{"foo-app-01.example.com" : ["example", "app", "decommission", "unneeded"],
 "foo-app-02.example.com" : ["example", "database", "upgrade"]}
```

<a name="delete_contacts_id_entitytags">&nbsp;</a>
### DELETE /contacts/CONTACT_ID/entity_tags

Delete tags from entities linked to a contact.

**Example 1 - JSON params**
```bash
curl -w 'response: %{http_code} \n' -X DELETE -H "Content-type: application/json" -d \
 '{
    "entity": {"foo-app-01.example.com" : ["unneeded"],
               "foo-app-02.example.com" : ["upgrade"]}
  }' \
 http://localhost:3081/contacts/21/entity_tags
```
**Example 2 - URL params**
```bash
curl -w 'response: %{http_code} \n' -X DELETE \
 'http://localhost:3081/contacts/21/entity_tags?entity[foo-app-01.example.com]=unneeded&entity[foo-app-02.example.com]=upgrade'
```
**Response** Status: 204 No Content
