
# Notification Rules

The Notification Rule resource has the following attributes:

Attribute | Type | Description
--- | --- | ---
id | String |
contact_id | String |
entities | Array[String] |
regex_entities | Array[String] |
tags | Array[String] |
regex_tags | Array[String] |
time_restrictions | |
unknown_media | Array[String] |
warning_media | Array[String] |
critical_media | Array[String] |
unknown_blackhole | Boolean |
warning_blackhole | Boolean |
critical_blackhole | Boolean |


## Create notification rules for a contact

```shell
curl -w 'response: %{http_code} \n' -X POST -H "Content-Type: application/vnd.api+json" -d \
 '{
    "notification_rules": [
      {
        "entities": [
          "foo-app-01.example.com"
        ],
        "regex_entities" : [
          "^foo-\S{3}-\d{2}.example.com$"
        ],
        "tags": [
          "database",
          "physical"
        ],
        "regex_tags" : [],
        "time_restrictions": [
          {
            "start_time": "2013-01-28 08:00:00",
            "end_time": "2013-01-28 18:00:00",
            "rrules": [
              {
                "validations": {
                  "day": [1,2,3,4,5]
                },
                "rule_type": "Weekly",
                "interval": 1,
                "week_start": 0
              }
            ],
            "exrules": [],
            "rtimes": [],
            "extimes": []
          }
        ],
        "unknown_media": [],
        "warning_media": [
          "email"
        ],
        "critical_media": [
          "sms",
          "email"
        ],
        "unknown_blackhole": false,
        "warning_blackhole": false,
        "critical_blackhole": false
      }
    ]
  }' \
http://localhost:3081/contacts/5/notification_rules
```

```ruby
require 'flapjack-diner'
Flapjack::Diner.base_uri('localhost:3081')

Flapjack::Diner.create_contact_notification_rules('5',
  {'entities'           => ['foo-app-01.example.com'],
   'regex_entities'     => ['^foo-\S{3}-\d{2}.example.com$'],
   'tags'               => ['database', 'physical'],
   'regex_tags'         => nil,
   'time_restrictions'  =>
     [{'start_time' => '2013-01-28 08:00:00',
       'end_time'   => '2013-01-28 18:00:00',
       'rrules'     =>
        [{'validations' => {'day' => [1, 2, 3, 4, 5]},
          'rule_type'   => 'Weekly',
          'interval'    => 1,
          'week_start'  => 0}],
      'exrules'       => [],
      'rtimes'        => [],
      'extimes'       => []}],
   'unknown_media'      => [],
   'warning_media'      => ['email'],
   'critical_media'     => ['sms', 'email'],
   'unknown_blackhole'  => false,
   'warning_blackhole'  => false,
   'critical_blackhole' => false})
```

### HTTP Request

`POST /contacts/CONTACT_ID/notification_rules`

### Query Parameters

Parameter | Type | Description
--------- | ---- | -----------
notification_rules | Array[NotificationRule] | An array of NotificationRule resources to create.

### HTTP Return Codes

Return code | Description
--------- | -----------
201 | The submitted notification rule resources were created successfully.
405 | **Error** The submitted notification rule data was not sent with the JSONAPI MIME type `application/vnd.api+json`.
409 | **Error** Notification rules with ids matching those submitted were found.
422 | **Error** The submitted notification rule data did not conform to the provided specification.


## Get notification rules

```shell
curl http://localhost:3081/notification_rules

# or
curl http://localhost:3081/notification_rules/30fd36ae-3922-4957-ae3e-c8f6dd27e543

# or
curl http://localhost:3081/notification_rules/30fd36ae-3922-4957-ae3e-c8f6dd27e543,bfd8be61-3d80-4b95-94df-6e77183ce4e3
```

```ruby
require 'flapjack-diner'
Flapjack::Diner.base_uri('localhost:3081')

Flapjack::Diner.notification_rules

# or
Flapjack::Diner.notification_rules(
  '30fd36ae-3922-4957-ae3e-c8f6dd27e543')

# or
Flapjack::Diner.notification_rules(
  '30fd36ae-3922-4957-ae3e-c8f6dd27e543',
  'bfd8be61-3d80-4b95-94df-6e77183ce4e3')
```

> The commands return JSON structured like this, which is broken up by Flapjack::Diner into its constituent hashes:

```json
{
  "notification_rules": [
    {
      "entities": [
        "foo-app-01.example.com"
      ],
      "regex_entities" : [
        "^foo-\S{3}-\d{2}.example.com$"
      ],
      "tags": [
        "database",
        "physical"
      ],
      "regex_tags" : [],
      "time_restrictions": [
        {
          "start_time": "2013-01-28 08:00:00",
          "end_time": "2013-01-28 18:00:00",
          "rrules": [
            {
              "validations": {
                "day": [1,2,3,4,5]
              },
              "rule_type": "Weekly",
              "interval": 1,
              "week_start": 0
            }
          ],
          "exrules": [],
          "rtimes": [],
          "extimes": []
        }
      ],
      "unknown_media": [],
      "warning_media": [
        "email"
      ],
      "critical_media": [
        "sms",
        "email"
      ],
      "unknown_blackhole": false,
      "warning_blackhole": false,
      "critical_blackhole": false,
      "links": {
        "contacts": ["12"]
      }
    }
  ]
}
```

### HTTP Request

`GET /notification_rules`

**or**

`GET /media/ID[,ID,ID...]`

### Query Parameters

None.

### HTTP Return Codes

Return code | Description
--------- | -----------
200 | OK


## Update notification rules

Update one or more attributes for one or more notification rules.

```shell
curl -w 'response: %{http_code} \n' -X PATCH -H "Content-Type: application/json-patch+json" -d \
'[
  {"op"    : "replace",
   "path"  : "/notification_rules/0/tags",
   "value" : ["leased", "small"]}
]' \
 'http://localhost:3081/notification_rules/a82fe0ec-1972-4c12-9732-6ebec9dcf479'
```

```ruby
require 'flapjack-diner'
Flapjack::Diner.base_uri('localhost:3081')

Flapjack::Diner.update_notification_rules(
  'a82fe0ec-1972-4c12-9732-6ebec9dcf479',
  :tags => ['leased', 'small'])
```

### HTTP Request

`PATCH /notification_rules/ID[,ID,ID...]`


### Query Parameters

Parameters sent for notification rule updates must form a valid [JSON Patch (RFC 6902)](http://tools.ietf.org/html/rfc6902) document. This is comprised of a bare JSON array of JSON-Patch operation objects, which have three members:

Parameter | Type | Description
--------- | ---- | -----------
op | String | may only be *replace*
path | String | "/notification_rules/0/ATTRIBUTE" (e.g. 'warning_blackhole')
value | -> | a value of the correct data type for the attribute in the path

### HTTP Return Codes

Return code | Description
--------- | -----------
204 | The submitted notification rule updates were made successfully. No content is returned.
404 | Notification rules could not be found for one or more of the provided ids. No notification rules were altered by this request.
405 | **Error** The submitted notification rule data was not sent with the JSON-Patch MIME type `application/json-patch+json`.


## Delete notification rules

Delete one or more notification rules.

```shell
curl -w 'response: %{http_code} \n' -X DELETE \
  'http://localhost:3081/notification_rules/2caf75f4-0043-4884-b2e9-dfb418e275ba'

# or
curl -w 'response: %{http_code} \n' -X DELETE \
  'http://localhost:3081/notification_rules/2caf75f4-0043-4884-b2e9-dfb418e275ba,bd0dd8b6-2c72-49da-9b83-e0b283ec1931'
```

```ruby
require 'flapjack-diner'
Flapjack::Diner.base_uri('localhost:3081')

Flapjack::Diner.delete_notification_rules(
  '2caf75f4-0043-4884-b2e9-dfb418e275ba')

# or
Flapjack::Diner.delete_notification_rules(
  '2caf75f4-0043-4884-b2e9-dfb418e275ba',
  'bd0dd8b6-2c72-49da-9b83-e0b283ec1931')
```

### HTTP Request

`DELETE /notification_rules/ID[,ID,ID...]`

### Query Parameters

None.

### HTTP Return Codes

Return code | Description
--------- | -----------
204 | The notification rule(s) were deleted
404 | Notification rules could not be found for one or more of the provided ids. No notification rules were deleted by this request.
