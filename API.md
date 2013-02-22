
API URLs
========

- `GET /entities`
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


*GET /entities*
```
get '/entities'
```

*GET /checks/ENTITY*
    get '/checks/:entity'

*GET /status/ENTITY[:CHECK]*
    get %r{/status/([a-zA-Z0-9][a-zA-Z0-9\.\-]*[a-zA-Z0-9])(?:/(\w+))?}

*GET /outages/ENTITY[:CHECK]*
    get %r{/outages/([a-zA-Z0-9][a-zA-Z0-9\.\-]*[a-zA-Z0-9])(?:/(\w+))?}

*GET /unscheduled_maintenances/ENTITY[:CHECK]*
    get %r{/unscheduled_maintenances/([a-zA-Z0-9][a-zA-Z0-9\.\-]*[a-zA-Z0-9])(?:/(\w+))?}

*GET /scheduled_maintenances/ENTITY[:CHECK]*
    get %r{/scheduled_maintenances/([a-zA-Z0-9][a-zA-Z0-9\.\-]*[a-zA-Z0-9])(?:/(\w+))?}

*GET /downtime/ENTITY[:CHECK]*
    get %r{/downtime/([a-zA-Z0-9][a-zA-Z0-9\.\-]*[a-zA-Z0-9])(?:/(\w+))?}

*POST /scheduled_maintenances/ENTITY/CHECK'*
    post '/scheduled_maintenances/:entity/:check'

*POST /test_notifications/ENTITY/CHECK*
    post '/test_notifications/:entity/:check'

*POST /entities*
    post '/entities'

*POST /contacts*
    post '/contacts'

*POST /acknowledgements/ENTITY/CHECK'*
    post '/acknowledgements/:entity/:check'
