
API URLs
========

```text
GET /entities
GET /checks/ENTITY
GET /status/ENTITY[/CHECK]
GET /outages/ENTITY[/CHECK]
GET /unscheduled_maintenances/ENTITY[/CHECK]
GET /scheduled_maintenances/ENTITY[/CHECK]
GET /downtime/ENTITY[/CHECK]
POST /scheduled_maintenances/ENTITY/CHECK
POST /acknowledgements/ENTITY/CHECK
POST /test_notifications/ENTITY/CHECK
POST /entities
POST /contacts
```

### GET /entities
Retrieve all the entities.
```ruby
get '/entities'
```

### GET /checks/ENTITY
Retrieve the names of the checks for the specified entity.
```ruby
get '/checks/:entity'
```

### GET /status/ENTITY[/CHECK]
Get the status of the specified check, or for all checks of the specified entity if no check is given.
```ruby
get %r{/status/([a-zA-Z0-9][a-zA-Z0-9\.\-]*[a-zA-Z0-9])(?:/(\w+))?}
```

### GET /outages/ENTITY[/CHECK]?start_time=START_TIME&end_time=END_TIME

Get the list of outages for the specified check, or for all checks of the specified entity if no check is given.
```ruby
get %r{/outages/([a-zA-Z0-9][a-zA-Z0-9\.\-]*[a-zA-Z0-9])(?:/(\w+))?}
```

### GET /unscheduled_maintenances/ENTITY[/CHECK]
Get the list of unscheduled maintenance periods for the specified check, or for all checks of the specified entity if no check is given.
```ruby
get %r{/unscheduled_maintenances/([a-zA-Z0-9][a-zA-Z0-9\.\-]*[a-zA-Z0-9])(?:/(\w+))?}
```

### GET /scheduled_maintenances/ENTITY[/CHECK]
Get the list of scheduled maintenance periods for the specified check, or for all checks of the specified entity if no check is given.
```ruby
get %r{/scheduled_maintenances/([a-zA-Z0-9][a-zA-Z0-9\.\-]*[a-zA-Z0-9])(?:/(\w+))?}
```

### GET /downtime/ENTITY[/CHECK]
Get the list of downtimes for the specified check, or for all checks of the specified entity if no check is given. Downtime is outages minus scheduled maintenances across any given time period.
```ruby
get %r{/downtime/([a-zA-Z0-9][a-zA-Z0-9\.\-]*[a-zA-Z0-9])(?:/(\w+))?}
```

### POST /scheduled_maintenances/ENTITY/CHECK'
Creates scheduled maintenance for the specified check.
```ruby
post '/scheduled_maintenances/:entity/:check'
```

### POST /acknowledgements/ENTITY/CHECK'
Acknowledges a problem on the specified check and creates unscheduled maintenance. 4 hrs is the default period but can be specied in the body. An optional message may also be supplied.
```ruby
post '/acknowledgements/:entity/:check'
```

### POST /test_notifications/ENTITY/CHECK
Generates test notifications for the specified check.
```ruby
post '/test_notifications/:entity/:check'
```

### POST /entities
Creates or updates entities from the supplied entities, using id as key.
```ruby
post '/entities'
```

### POST /contacts
Deletes all contacts before importing the supplied contacts.
```ruby
post '/contacts'
```

