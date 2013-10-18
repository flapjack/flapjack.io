NB: This is using a Redis ORM layer provisionally named RedisRecord, which provides an ActiveModel implementation over a Redis data store. Everything below is subject to confirmation, pending review.

The following documentation just lists the data fields at the moment; more commentary regarding valid values etc. will be added soon.

TODO: catch up the code with the key naming below

TODO: the indexing columns, `by_*` below should maybe be renamed `ids_by_*`.

TODO: where index key must be unique, could use a global index hash for that key instead of multiple lists.

TODO: notification rule media/blackhole should be moved to 3 child objects, based on state

TODO: Notification/Message should be persisted to Redis, the ID posted to the queue and deleted on pickup by the notifier/gateway. We may preserve the original JSON data format as a parallel means of passing messages to the gateways by external processes ("to notifier" is more of an internal concern).

### Data type definitions

    HASH, SET, ZSET -- corresponding Redis types
    BOOLEAN -- string, either 'true' or 'false'
    TIMESTAMP -- string, number of seconds since the Unix epoch
    ID -- string representing a RedisRecord id
    STRING
    INTEGER

### Entities

    # global
    entity:ids                -> SET of IDs
    entity:by_name:NAME       -> multiple SETs of IDs (unique key)
    entity:by_enabled:ENABLED -> two SETs of IDs, as enabled is a BOOLEAN

    # single record
    entity:ID:attrs          -> HASH
      {name,                   -> STRING
       enabled}                -> BOOLEAN
    entity:ID:tags           -> SET of STRINGs
    entity:ID:contact_ids    -> SET of IDs of Contact records
    entity:ID:check_ids      -> SET of IDs of Check records

### Checks

    # global
    check:ids                         -> SET of IDs
    check:by_entity_name:ENTITY_NAME  -> multiple SETs of IDs
    check:by_name:NAME                -> multiple SETs of IDs
    check:by_enabled:ENABLED          -> two SETs of IDs, as enabled is a BOOLEAN
    check:by_state:STATE              -> four SETs of IDs (valid values for 'state')
    
    # single record
    check:ID:attrs                                 -> HASH
      {entity_name,                                  -> STRING
       name,                                         -> STRING
       state,                                        -> STRING
       summary,                                      -> STRING
       details,                                      -> STRING
       last_update,                                  -> TIMESTAMP
       enabled}                                      -> BOOLEAN
    check:ID:contact_ids                           -> SET
    check:ID:state_ids                             -> ZSET, timestamp key
    check:ID:scheduled_maintenances_by_start_ids   -> ZSET, start_time key
    check:ID:scheduled_maintenances_by_end_ids     -> ZSET, end_time key
    check:ID:unscheduled_maintenances_by_start_ids -> ZSET, start_time key
    check:ID:unscheduled_maintenances_by_end_ids   -> ZSET, end_time key


### Check state changes & notifications

    # global
    check_state:ids            -> SET of IDs
    check_state:by_state       -> four SETs of IDs
    check_state:by_notified    -> two SETs of IDS, as notified is a BOOLEAN
    check_state:by_count       -> multiple SETs of IDs (unique key)

    # single record
    check_state:ID:attrs              -> HASH
      {summary,                         -> STRING
       details,                         -> STRING
       count,                           -> INTEGER
       timestamp,                       -> TIMESTAMP
       notified}                        -> BOOLEAN
    check_state:ID:notification_times -> SET of TIMESTAMPS

### Unscheduled maintenance periods & notifications

    # global
    unscheduled_maintenance:ids                      -> SET of IDs

    # single record
    unscheduled_maintenance:ID:attrs                -> HASH
      {start_time,                                    -> TIMESTAMP
       end_time,                                      -> TIMESTAMP
       summary,                                       -> STRING
       notified}                                      -> BOOLEAN
    unscheduled_maintenance:ID:notification_times    -> SET of TIMESTAMPs
    unscheduled_maintenance:ID:belongs_to            -> HASH {'check_id' => ID}
    
### Scheduled maintenance periods

    # global
    scheduled_maintenance:ids                        -> SET of IDs

    # single record
    scheduled_maintenance:ID:attrs                   -> HASH
      {start_time,                                      -> TIMESTAMP
       end_time,                                        -> TIMESTAMP
       summary}                                         -> STRING
    scheduled_maintenance:ID:belongs_to              -> HASH {'check_id' => ID}

### Notification

    # global
    notification:ids            -> SET of IDs
    
    # single record
    notification:ID:attrs       -> HASH
      {entity_check_id,           -> ID
       state_id,                  -> ID
       state_duration,            -> INTEGER
       previous_state_id,         -> ID
       severity,                  -> STRING
       type,                      -> STRING
       time,                      -> TIMESTAMP
       duration}                  -> INTEGER
    notification:ID:tags          -> SET of STRINGs

### Contacts

    # global
    contact:ids                       -> SET of IDs
    
    # single record
    contact:ID:attrs                  -> HASH
      {first_name                       -> STRING
       last_name                        -> STRING
       email                            -> STRING
       timezone}                        -> STRING
    contact:ID:pagerduty_credentials  -> HASH
    contact:ID:tags                   -> SET of STRINGs
    contact:ID:entities               -> SET of IDs of Entity records
    contact:ID:media                  -> SET of IDs of Medium records
    contact:ID:notification_rules     -> SET of IDs of NotificationRule records
    contact:ID:notification_blocks    -> ZSET of IDs of NotificationBlock records, expire_at key

### Message media

    # global
    medium:ids        -> SET of IDs
    medium:by_type    -> multiple SETs of IDs
    
    # single record
    medium:ID:attrs   -> HASH
      {type             -> STRING
       address          -> STRING
       interval}        -> INTEGER
    

### Notification rules

    # global
    notification_rule:ids                 -> SET of IDs
    
    # single record
    notification_rule:ID:attrs            -> HASH
      {time_restrictions,                   -> JSON_STRING
       unknown_blackhole,                   -> BOOLEAN
       warning_blackhole,                   -> BOOLEAN
       critical_blackhole}                  -> BOOLEAN
    notification_rule:ID:entities         -> SET of STRINGs (entity names)
    notification_rule:ID:tags             -> SET of STRINGs
    notification_rule:ID:unknown_media    -> SET of STRINGs (media types)
    notification_rule:ID:warning_media    -> SET of STRINGs (media types)
    notification_rule:ID:critical_media   -> SET of STRINGs (media types)
    notification_rule:ID:belongs_to       -> HASH {'contact_id' => ID}

### Notification blocks

    # global
    notification_block:ids                  -> SET of IDs
    notification_block:by_media_type        -> SET of IDs
    notification_block:by_entity_check_id   -> SET of IDs
    notification_block:by_state             -> SET of IDs
    
    # single record
    notification_block:ID:attrs             -> HASH
      {expire_at                              -> TIMESTAMP
       media_type                             -> MEDIA_TYPE
       entity_check_id                        -> ID
       state}                                 -> STRING
    notification_block:ID:belongs_to        -> HASH {'contact_id' => ID}

### Message

    # global
    message:ids
    
    # single record
    message:ID:attrs
      TODO
