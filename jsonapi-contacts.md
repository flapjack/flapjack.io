<ul>
  <li><a href="#get_contacts">GET /contacts</a></li>
  <li><a href="#get_contacts_id">GET /contacts/CONTACT_ID</a></li>
  <li><a href="#post_contacts">POST /contacts</a></li>
  <li><a href="#put_contacts_id">PUT, DELETE /contacts/CONTACT_ID</a></li>
  <li><a href="#delete_contacts">DELETE /contacts</a></li>
</ul>

<a id="get_contacts">&nbsp;</a>
#### GET /contacts

Returns all the contacts

**Example**
```bash
curl http://localhost:3081/contacts
```

```json
{
  "contacts": [
    {
      "id": "21",
      "first_name": "Ada",
      "last_name": "Lovelace",
      "email": "ada@example.com",
      "timezone": "Europe/London",
      "tags": [
        "legend",
        "first computer programmer"
      ]
    },
    {
      "id": "22",
      "first_name": "Charles",
      "last_name": "Babbage",
      "email": "babbage@example.com",
      "timezone": "UTC",
      "tags": [
        "grump"
      ]
    }
  ]
}
```


<a id="get_contacts_id">&nbsp;</a>
#### GET /contacts/CONTACT_ID

Returns the core information of a specified contact.

**Example**
```bash
curl http://localhost:3081/contacts/21
```

```json
{
  "contacts": [
    {
      "id": "21",
      "first_name": "Ada",
      "last_name": "Lovelace",
      "email": "ada@example.com",
      "media": {
        "sms": "+61412345678",
        "email": "ada@example.com"
      },
      "media_intervals": {
        "sms": "3600",
        "email": "7200"
      },
      "media_rollup_thresholds": {
        "sms": "5"
      },
      "timezone": "Europe/London",
      "tags": [
        "legend",
        "first computer programmer"
      ]
    }
  ]
}
```


<a id="post_contacts">&nbsp;</a>
#### POST /contacts

Creates one or more contacts, returns an array containing the IDs of the created contacts. The ordering is preserved, so if you POST an array of three contacts, the resulting array of IDs will be in the same order as the posted data, so the first item of the POSTed array will correspond to the first ID in the resulting array, etc.

The ID may optionally be supplied. If it is ommitted, then a UUID will be created.

If ID is supplied in any of the included contacts, and any of them clash with an existing contact, the whole request will be rejected and no changes will be written.

**Input JSON Format**
```text
CONTACTS  (array) = [ CONTACT, CONTACT, ...]
CONTACT   (hash)  = { "id": CONTACT_ID, "first_name": FIRST_NAME, "last_name": LAST_NAME,
                      "email": EMAIL, "media": MEDIAS, "timezone": TIMEZONE, "tags": TAGS }
MEDIAS    (hash)  = { MEDIA_TYPE: MEDIA, MEDIA_TYPE: MEDIA, "pagerduty": PAGERDUTY... }
MEDIA     (hash)  = { "address": MEDIA_ADDRESS,
                      "interval": INTERVAL,
                      "rollup_threshold": FAILURE_COUNT }
PAGERDUTY (hash)  = { "service_key": PAGERDUTY_SERVICE_KEY, "subdomain": PAGERDUTY_SUBDOMAIN,
                      "username": PAGERDUTY_USERNAME, "password": PAGERDUTY_PASSWORD }
TAGS      (array) = [ "TAG", "TAG", ...]

CONTACT_ID            (string) - a unique, immutable identifier for this contact (optional). If ommitted, a UUID will be created
MEDIA_TYPE            (string) - one of "email", "sms", "jabber", or any other media type we add support for in the future
MEDIA_ADDRESS         (string) - address to send to for the paired MEDIA_TYPE, eg an email address, mobile phone number, or jabber id
PAGERDUTY_SERVICE_KEY (string) - the API key for PagerDuty's integration API, corresponds to a 'service' within this contact's PagerDuty account
PAGERDUTY_SUBDOMAIN   (string) - the subdomain for this contact's PagerDuty account, eg "companyname" in the case of https://companyname.pagerduty.com/
PAGERDUTY_USERNAME    (string) - the username for the PagerDuty REST API (basic http auth) for reading data back out of PagerDuty
PAGERDUTY_PASSWORD    (string) - the password for the PagerDuty REST API
TIMEZONE              (string) - A timezone string eg 'UTC', 'Australia/Broken_Hill', etc
TAG                   (string) - a tag, you know?
INTERVAL              (string) - number of seconds to repeat the same alert on this media type
FAILURE_COUNT         (string) - the number of failing checks this contact has before rollup kicks in, 0 and null mean never
```

**Notes:**
* The "email" key in the CONTACT hash is not to be used for sending alerts, it is supplied as a qualification of the contact's identity only. Only the "email" key in the MEDIA hash, if present, is to be used for notifications.
* The value for ID must be unique and must never change as it is used for synchronisation during updates.
* The "pagerduty" hash may or may not be present. If absent, any existing pagerduty info for the contact will be removed on import.

**Example**
```bash
curl -w 'response: %{http_code} \n' -X POST -H "Content-type: application/json" -d \
 '{
    "contacts": [
      {
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
        "timezone": "Europe/London",
        "tags": [
          "legend",
          "first computer programmer"
        ]
      }
    ]
  }' \
 http://localhost:3081/contacts
```
**Response** Status: 200 OK
```json
[
  '4b5897cf-9ba4-4da5-b317-64497e5a49de'
]
```


<a id="put_contacts_id">&nbsp;</a>
#### PUT, DELETE /contacts/CONTACT_ID

Updates, or deletes, a contact.

The data format (for PUT) is the same as the CONTACT hash detailed in <a href="#post_contacts">POST /contacts</a>. ID may be supplied, but must not conflict with the ID passed in the URL.

**Example 1 - PUT**
``` bash
curl -w 'response: %{http_code} \n' -X PUT -H "Content-type: application/json" -d \
'{
  "contacts": [
    {
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
      "timezone": "Europe/London",
      "tags": [
        "legend",
        "first computer programmer"
      ]
    }
  ]
}' \
 'http://localhost:3081/contacts/21'
```

**Example 2 - DELETE**

``` bash
curl -w 'response: %{http_code} \n' -X DELETE \
  'http://localhost:3081/contacts/21'
```

<a id="delete_contacts">&nbsp;</a>
#### DELETE /contacts?id[]=CONTACT_ID[&id[]=CONTACT_ID[...]]

Deletes multiple contacts.

``` bash
curl -w 'response: %{http_code} \n' -X DELETE \
  'http://localhost:3081/contacts?id[]=21&id[]=22'
```


