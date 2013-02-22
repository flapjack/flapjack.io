
API URLs
========

- [link](#get-/entities) `GET /entities`
- `GET /checks/ENTITY`
- `GET /status/ENTITY[:CHECK]`
- `GET /outages/ENTITY[:CHECK]`
- `GET /unscheduled_maintenances/ENTITY[:CHECK]`
- `GET /scheduled_maintenances/ENTITY[:CHECK]`
- `GET /downtime/ENTITY[:CHECK]`
- `POST /scheduled_maintenances/ENTITY/CHECK`
- `POST /acknowledgements/ENTITY/CHECK`
- `POST /test_notifications/ENTITY/CHECK`
- `POST /entities`
- `POST /contacts`


### GET /entities
```ruby
get '/entities'
```

### GET /checks/ENTITY
```ruby
get '/checks/:entity'
```

### GET /status/ENTITY[:CHECK]
```ruby
get %r{/status/([a-zA-Z0-9][a-zA-Z0-9\.\-]*[a-zA-Z0-9])(?:/(\w+))?}
```

### GET /outages/ENTITY[:CHECK]
```ruby
get %r{/outages/([a-zA-Z0-9][a-zA-Z0-9\.\-]*[a-zA-Z0-9])(?:/(\w+))?}
```

### GET /unscheduled_maintenances/ENTITY[:CHECK]
```ruby
get %r{/unscheduled_maintenances/([a-zA-Z0-9][a-zA-Z0-9\.\-]*[a-zA-Z0-9])(?:/(\w+))?}
```

### GET /scheduled_maintenances/ENTITY[:CHECK]
```ruby
get %r{/scheduled_maintenances/([a-zA-Z0-9][a-zA-Z0-9\.\-]*[a-zA-Z0-9])(?:/(\w+))?}
```

### GET /downtime/ENTITY[:CHECK]
```ruby
get %r{/downtime/([a-zA-Z0-9][a-zA-Z0-9\.\-]*[a-zA-Z0-9])(?:/(\w+))?}
```

### POST /scheduled_maintenances/ENTITY/CHECK'
```ruby
post '/scheduled_maintenances/:entity/:check'
```

### POST /test_notifications/ENTITY/CHECK
```ruby
post '/test_notifications/:entity/:check'
```

### POST /entities
```ruby
post '/entities'
```

### POST /contacts
```ruby
post '/contacts'
```

### POST /acknowledgements/ENTITY/CHECK'
```ruby
post '/acknowledgements/:entity/:check'
```
