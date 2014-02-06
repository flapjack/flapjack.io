# [JSON API](jsonapi) :: Test

## Endpoints

* [POST /test_notifications/ENTITY/CHECK](#post_test_notifications)

<a id="post_test_notifications">&nbsp;</a>
### POST /test_notifications/ENTITY/CHECK
Generates test notifications for the specified check. Body can be left empty.

**Input JSON Format**
```text
(BULK is only used if the entity and check are not provided in the request URL.)

BULK          (hash) = { "entity" : ENTITIES,
                         "check" : ENTITY_CHECKS }
ENTITY      (string) = entity name
ENTITIES    (string) = ENTITY or
            (array)    [ENTITY, ...]
ENTITY_CHECKS (hash) = { ENTITY : CHECKS, ... }
CHECK       (string) = check name
CHECKS      (string) = CHECK or
             (array)   [CHECK, ...]
```

**Example 1**
```bash
curl -X POST "http://localhost:3081/test_notifications/foo-app-01.example.com/HOST"
```

**Example 2**
```bash
curl -w 'response: %{http_code} \n' -X POST -H "Content-type: application/json" -d \
 '{
    "entity": "foo-app-02.example.com"
  }' \
 http://localhost:3081/test_notifications
```

**Response** Status: 204 No Content
