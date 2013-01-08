## Flapjack Data Structures in Redis

Flapjack is using redis as its data store. Here are the data structures in use.

### Event queue

```
events (list) -> [ EVENT, EVENT, ... ]

EVENT      (string) - a ruby hash serialised in JSON: { 'host' => ENTITY, 'service' => SERVICE, 'type' => EVENT_TYPE, 'state' => STATE }
EVENT_TYPE (string) - one of 'service' or 'action'
STATE      (string) - one of 'ok', 'warning', 'critical', 'unknown', 'acknowledgement'
```

### Jabber notification queue

```
jabber_notifications (list) -> [ NOTIFICATION, NOTIFICATION, ... ]

NOTIFICATION (string) - ruby hash representing the notification object, serialised in JSON
```

### PagerDuty notification queue

```
pagerduty_notifications (list) -> [ NOTIFICATION, NOTIFICATION, ... ]

NOTIFICATION (string) - ruby hash representing the notification object, serialised in JSON
```

### Storing all service state changes

*Current state*

```
check:ENTITY:CHECK (hash) -> { 'state' => STATE, 'last_change' => TIMESTAMP, 'last_update' => TIMESTAMP }
```


The current state hash above is redundant given the All state changes structures below, but may provide a speed improvement.

The `last_update` timestamp is updated for every service event received for the service.

*All state changes*
```
ENTITY:CHECK:states                    (list) -> [ TIMESTAMP, TIMESTAMP, ... ]
ENTITY:CHECK:TIMESTAMP:state         (string) -> STATE
ENTITY:CHECK:TIMESTAMP:summary       (string) -> SUMMARY
ENTITY:CHECK:TIMESTAMP:count         (string) -> COUNT
ENTITY:CHECK:TIMESTAMP:check_latency (string) -> LATENCY
```

The All state changes may be better implemented as a serialised ruby hash in a single key rather than four keys per service as it is now.

In order to query against this data while filtering by timestamp range, the following mirror of the list is being maintained:

*Sorted state timestamps*

```
ENTITY:CHECK:sorted_state_timestamps (sorted set) -> (TIMESTAMP, TIMESTAMP; TIMESTAP, TIMESTAMP; ...)
```

### Storing all action events

```
ENTITY:CHECK:actions (hash) -> { TIMESTAMP => STATE }

STATE (string) - eg 'acknowledgement'
```

This should probably be a hash, or a set of keys as per service state changes, so we can store more information about the action event such as an acknowledgement message like 'will have this fixed in a jiffy, seen this problem before'.

### Failed checks

*Failed services for all clients*

    failed_checks (sorted set) -> ( TIMESTAMP, ENTITY:CHECK ; TIMESTAMP, ENTITY:CHECK ; ... )

*Failed services under a client id*

    failed_checks:CLIENT (sorted set) -> ( TIMESTAMP, ENTITY:CHECK ; TIMESTAMP, ENTITY:CHECK ; ... )

### Mass failures, eg for a client

```
mass_failed_client:CLIENT (string) -> TIMESTAMP

TIMESTAMP - holds the time the mass failure begun, unix time
```

```
mass_failure_events_client:CLIENT (ordered set) -> ( DURATION, TIMESTAMP; DURATION, TIMESTAMP; ... )

DURATION - initially 0, populated with the total duration (seconds) of the mass failure event when it ends
```

### Unscheduled Maintenance

This key will only be present during the unschedule maintenance period for quick lookup of whether a service is in unschedule maintenance. An expiry TTL will be put on the key so it automatically goes away (default 4 hrs expiry time).

*Current state*
```
ENTITY:CHECK:unscheduled_maintenance (string with expiry) -> TIMESTAMP

TIMESTAMP - the time the unscheduled maintenance begun
```

*Collect all unscheduled outages for reporting etc*
```
ENTITY:CHECK:unscheduled_maintenances             (ordered set) -> ( DURATION, TIMESTAMP;
                                                                     DURATION, TIMESTAMP; ... )
ENTITY:CHECK:TIMESTAMP:unscheduled_maintenance:summary (string) -> SUMMARY

TIMESTAMP - start of the unscheduled maintenance period
DURATION  - the elapsed time of the unscheduled maintenance (including any extensions to the original period)
SUMMARY   - populated from the summary of the acknowledgement(s) (summaries to be glued together if there are multiple during an unscheduled outage)
```

In order to query against this data while filtering by timestamp range, the following mirror of the above sorted set is being maintained:

*Sorted unscheduled maintenance timestamps*
```
ENTITY:CHECK:sorted_unscheduled_maintenance_timestamps (ordered set) -> ( TIMESTAMP, TIMESTAMP; TIMESTAMP, TIMESTAMP; ... )
```

### Scheduled Maintenance

This key will only be present during the scheduled maintenance period for quick lookup of whether a check is in scheduled maintenance. An expiry TTL (4 hours by default) will be put on the key so it destroys itself after this time.

*Current state*
```
ENTITY:CHECK:scheduled_maintenance (string with expiry) -> TIMESTAMP

TIMESTAMP - the time the scheduled maintenance begun
```

*All future scheduled outages, and left for reporting purposes*
```
ENTITY:CHECK:scheduled_maintenances (ordered set)             -> ( DURATION, TIMESTAMP;
                                                                   DURATION, TIMESTAMP; ... )
ENTITY:CHECK:TIMESTAMP:scheduled_maintenance:summary (string) -> SUMMARY

TIMESTAMP - start of the scheduled maintenance period
DURATION  - the elapsed time of the scheduled maintenance window (including any extensions to the original period)
SUMMARY    - populated from the summary of the scheduled maintenance creation event(s) (summaries to be glued together if there are multiple)
```

In order to query against this data while filtering by timestamp range, the following mirror of the above sorted set is being maintained:

*Sorted scheduled maintenance timestamps*
```
ENTITY:CHECK:sorted_scheduled_maintenance_timestamps (ordered set) -> ( TIMESTAMP, TIMESTAMP; TIMESTAMP, TIMESTAMP; ... )

TIMESTAMP - start of the scheduled maintenance period (duplicated, in both the score and value of each item in the ordered set)
```

### Notifications

We need to store alerts that have been sent out, for problems, recoveries, and acknowledgements. We'll need to track who they are sent as well but for now it's just whether an alert has been generated or not.

*Last alert of each type (problem, recovery, acknowledgement)*
```
ENTITY:CHECK:last_problem_notification         (string) -> TIMESTAMP
ENTITY:CHECK:last_recovery_notification        (string) -> TIMESTAMP
ENTITY:CHECK:last_acknowledgement_notification (string) -> TIMESTAMP

TIMESTAMP - the time of the last notification sent of the corresponding type (problem, recovery, acknowledgement)
```

*Retention of all alerts*
```
ENTITY:CHECK:problem_notifications         (list) -> [ TIMESTAMP, TIMESTAMP, ... ]
ENTITY:CHECK:recovery_notifications        (list) -> [ TIMESTAMP, TIMESTAMP, ... ]
ENTITY:CHECK:acknowledgement_notifications (list) -> [ TIMESTAMP, TIMESTAMP, ... ]
```

We may well need to add some extra data about each notification, eg timestamp of related (un)scheduled maintenance, timestamp of related check state changes (failure and ok).

### Contacts

We need to store contacts for entities and checks in redis, after extraction from customer care, so we know who to send alerts to.

```
contact:CONTACT_ID           (hash) -> { 'first_name' => FIRST_NAME, 'last_name' => LAST_NAME, 'email' => EMAIL }
contact_media:CONTACT_ID     (hash) -> { 'email' => EMAIL, 'sms' => PHONE_NUMBER, 'jabber' => JABBER_ID,
                                         'pagerduty' => PAGERDUTY_SERVICE_KEY }
contact_pagerduty:CONTACT_ID (hash) -> { 'subdomain': PAGERDUTY_SUBDOMAIN, 'username': PAGERDUTY_USERNAME,
                                         'password': PAGERDUTY_PASSWORD }
contact_tag:TAG              (set)  -> ( CONTACT_ID, CONTACT_ID, ...)
CONTACT_ID: the ID number of the contact in custcare
PHONE_NUMBER: a phone number in international format, starting with +
JABBER_ID             (string) - the jabber id of the contact, eg 'adalovelace@jabber.charlesbabbage.com', can be a group chat
PAGERDUTY_SERVICE_KEY (string) - the API key for PagerDuty's integration API, corresponds to a 'service' within this contact's PagerDuty account
PAGERDUTY_SUBDOMAIN   (string) - the subdomain for this contact's PagerDuty account, eg "bltprf" in the case of https://bltprf.pagerduty.com/
PAGERDUTY_USERNAME    (string) - the username for the PagerDuty REST API (basic http auth) for reading data back out of PagerDuty
PAGERDUTY_PASSWORD    (string) - the password for the PagerDuty REST API
TAG                   (string) - arbitrary tag
```

Notes:

- `contact:CONTACT_ID` is about the contact, `contac_media:CONTACT_ID` lists which contact methods to use for this contact (so if it just contains sms then we'll only notify this person by sms).
- Initially IM and Phone notification media will not be supported (just SMS and Email).
- `EMAIL` ... note that this is potentially duplicated, the email field in contact:CONTACT_ID is really just for matching up users and is not used as a contact media
- `JABBER_ID` - may be a jabber id of an individual, or of a group chat room. If a group chat room this jabber_id should also be included in the flapjack configuration file so that flapjack jabber gateway joins the group chat

### Entity and Check Contacts

Which contacts are interested in which entities and/or which checks?

```
contacts_for:ENTITY_ID       (set) -> ( CONTACT_ID, CONTACT_ID, ... )
contacts_for:ENTITY_ID:CHECK (set) -> ( CONTACT_ID, CONTACT_ID, ... )
entity:ENTITY_ID            (hash) -> { 'name' => ENTITY }
entity_id:ENTITY          (string) -> ENTITY_ID
entity_tag:TAG               (set) -> ( ENTITY_ID, ENTITY_ID, ... )

ENTITY_ID is a unique, immutable identifier given to each entity. This allows the name of the entity to change (eg a host gets renamed) and synchronisation to not go out of whack.
TAG - arbitrary tag
```

Note, it may be more sensible to flip ENTITY and ENTITY_ID around so that there's less lookups involved in each notification. (the ID is really only here for matching up when importing new / changed entities.)

Also, the `entity:ENTITY_ID` hash could be just a string, but I'm guessing we'll find other entity meta data we'll want to throw in here.

### Event processor statistics

The following counters are incremented during event processing so we can see how many events flapjack is processing, and of which types.

```
event_counters (hash) -> { all => COUNTER, ok => COUNTER, failure => COUNTER, action => COUNTER }
boot_time    (string) -> TIMESTAMP

COUNTER - incrementing integer counter, reset to zero when the event processor boots
```

"The range of values supported by HINCRBY is limited to 64 bit signed integers." So up to 9,223,372,036,854,775,807. I guess we'll need to reset it on occasion - at midnight perhaps. But if we're getting that many events during a run of flapjack-executive then we probably have other problems...

To support multiple concurrent executive instances:

```
executive_instances    (ordered set) -> (BOOTTIME, HOSTIDENT:PID; BOOTTIME, HOSTIDENT:PID; ...)
event_counters:HOSTIDENT:PID  (hash) -> { all => COUNTER, ok => COUNTER, failure => COUNTER, action => COUNTER }
```

