# [JSON API](jsonapi) :: Checks

## Endpoints

* [GET /checks/ENTITY](#get_checks)

<a id="get_checks">&nbsp;</a>
### GET /checks/ENTITY
Retrieve the names of the checks for the specified entity.

**Output JSON Format**
```text
CHECKS   (array) = [ CHECK_NAME, CHECK_NAME, ... ]
```

**Example**
```bash
curl http://localhost:3081/checks/foo-app-02.example.com
```
**Response** Status: 200 OK
```json
[
   "HOST",
   "HTTP Port 443"
]
```
