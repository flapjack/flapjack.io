---
title: Flapjack API Reference

language_tabs:
  - shell
  - ruby

---

# Introduction

See the [flapjack-diner](https://github.com/flpjck/flapjack-diner/) gem which provides a ruby consumer of this API.


# Contacts


## Create contacts

Creates one or more contacts, returns an array containing the IDs of the created contacts. The ordering is preserved, so if you POST an array of three contacts, the resulting array of IDs will be in the same order as the posted data, so the first item of the POSTed array will correspond to the first ID in the resulting array, etc.

The ID may optionally be supplied. If it is omitted, then a UUID will be created.

If ID is supplied in any of the included contacts, and any of them clash with an existing contact, the whole request will be rejected and no changes will be written.

```shell
curl -w 'response: %{http_code} \n' -X POST -H "Content-type: application/vnd.api+json" -d \
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

```ruby
require 'flapjack-diner'
Flapjack::Diner.base_uri('localhost:3081')

Flapjack::Diner.create_contacts!({"first_name" => "Ada",
                                  "last_name"  => "Lovelace",
                                  "email"      => "ada@example.com"})
```

> The above command returns JSON structured like this:

```json
["cd40283b-023e-43e2-a79c-1910415afdc2"]
```

### HTTP Request

### Query Parameters

### HTTP Return Codes

Return code | Description
--------- | -----------
201 | The submitted contacts were created successfully.
405 | **Error** The submitted contact data was not sent with the JSONAPI MIME type `application/vnd.api+json`.
409 | **Error** Contacts with ids matching those submitted were found.
422 | **Error** The submitted contact data did not conform to the provided specification.


## Get all contacts

```ruby
require 'flapjack-diner'
Flapjack::Diner.base_uri('localhost:3081')

Flapjack::Diner.contacts
```

```shell
curl http://localhost:3081/contacts
```

> The above command returns JSON structured like this:

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

This endpoint returns all contacts.

### HTTP Request

`GET http://localhost:3081/contacts`

### Query Parameters

None.

### HTTP Return Codes

Return code | Description
--------- | -----------
200 | OK


## Get specific contacts

```ruby
require 'flapjack-diner'
Flapjack::Diner.base_uri('localhost:3081')

Flapjack::Diner.contacts(1)
```

```shell
curl http://localhost:3081/contacts/1
```

> The above command returns JSON structured like this:

```json
{
  "contacts": [
    {
      "id": "1",
      "first_name": "Ada",
      "last_name": "Lovelace",
      "email": "ada@example.com",
      "timezone": "Europe/London",
      "tags": [
        "legend",
        "first computer programmer"
      ]
    }
  ]
}
```

This endpoint returns one or more contacts.

### HTTP Request

`GET http://localhost:3081/contacts/ID[,ID,...]`

### Query Parameters

Parameter | Description
--------- | -----------
ID | The ids of the contact(s) to retrieve, comma-separated for multiple contacts.

### HTTP Return Codes

Return code | Description
--------- | -----------
200 | OK


## Update contacts

### HTTP Request

### Query Parameters


## Delete contacts

### HTTP Request

### Query Parameters


# Media

## Create media for a contact

### HTTP Request

### Query Parameters


## Get media

Not yet implemented


## Update media

### HTTP Request

### Query Parameters


## Delete media

Not yet implemented.


# Notification Rules


## Create notification rules for a contact

### HTTP Request

### Query Parameters


## Get notification rules

### HTTP Request

### Query Parameters


## Update notification rules

### HTTP Request

### Query Parameters


## Delete notification rules

### HTTP Request

### Query Parameters


# Entities & Checks


## Create entities

### HTTP Request

### Query Parameters


## Get entities

### HTTP Request

### Query Parameters


## Update entities

### HTTP Request

### Query Parameters


## Create scheduled maintenance periods on entities & checks

### HTTP Request

### Query Parameters


## Delete scheduled maintenance periods on entities & checks

### HTTP Request

### Query Parameters


## Create unscheduled maintenance periods on entities & checks

### HTTP Request

### Query Parameters


## Delete unscheduled maintenance periods on entities & checks

### HTTP Request

### Query Parameters


## Create test notifications on entities & checks

### HTTP Request

### Query Parameters


# Reports


## Get report on status of entities & checks

### HTTP Request

### Query Parameters


## Get report on unscheduled maintenance periods of entities & checks

### HTTP Request

### Query Parameters


## Get report on scheduled maintenance periods of entities & checks

### HTTP Request

### Query Parameters


## Get report on outages of entities & checks

### HTTP Request

### Query Parameters


## Get report on downtime of entities & checks

### HTTP Request

### Query Parameters

