## Flapjack Data Structures in Redis

Flapjack is using redis as its data store. Here are the data structures in use.

### Event queue


``` text
events (list) -> [ EVENT, EVENT, ... ]

EVENT      (string) - A Ruby hash serialised in JSON: 

                     { 
                       'entity'   => ENTITY,
                       'check'    => CHECK,
                       'type'     => EVENT_TYPE,
                       'state'    => STATE,
                       'time'     => TIMESTAMP,
                       'summary'  => SUMMARY,
                       'details'  => DETAILS,
                       'tags'     => TAGS,
                       'perfdata' => PERFDATA
                     }
                     
ENTITY     (string)   - Name of the relevant entity (e.g. FQDN)
CHECK      (string)   - The check name ('service description' in Nagios terminology)
EVENT_TYPE (string)   - One of 'service' or 'action'
STATE      (string)   - One of 'ok', 'warning', 'critical', 'unknown', 'acknowledgement'
TIMESTAMP  (string)   - UNIX timestamp of the event's creation
SUMMARY    (string)   - The check output in the case of a service event, otherwise a
                        message created for an acknowledgement or similar
DETAILS    (string)   - Long check output for a Nagios service event
PERFDATA   (string)   - Performance data for a Nagios service event
TAGS       (string[]) - Array of tags pertaining to the event
```

### Event Archive (sliding window)

Version 0.7.1 +

If enabled in the configuration (environment / executive / archive_events) flapjack
will save a copy of events as they are being processed into this data structure. The
keys used for the archive are changed every hour and an expiry placed on the keys
taken from the configuration (environment / executive / events_archive_maxage - seconds).

```text
events_archive:YYYYMMDDHH (list, with expiry) -> [ EVENT, EVENT, ...]

EVENT - see the Event queue documentation above
```

### Jabber notification queue

```text
jabber_notifications (list) -> [ NOTIFICATION, NOTIFICATION, ... ]

NOTIFICATION (string) - ruby hash representing the notification object, serialised in JSON
```

### PagerDuty notification queue

```text
pagerduty_notifications (list) -> [ NOTIFICATION, NOTIFICATION, ... ]

NOTIFICATION (string) - ruby hash representing the notification object, serialised in JSON
```

### Storing all check state changes

*Current state*

```text
check:ENTITY:CHECK (hash) -> { 'state' => STATE, 'last_change' => TIMESTAMP, 'last_update' => TIMESTAMP }
```

The current state hash above is redundant given the All state changes structures below, but may provide a speed improvement.

The `last_update` timestamp is updated for every service event received for the service.

*All state changes*
```text
ENTITY:CHECK:states                    (list) -> [ TIMESTAMP, TIMESTAMP, ... ]
ENTITY:CHECK:TIMESTAMP:state         (string) -> STATE
ENTITY:CHECK:TIMESTAMP:summary       (string) -> SUMMARY
ENTITY:CHECK:TIMESTAMP:count         (string) -> COUNT
ENTITY:CHECK:TIMESTAMP:check_latency (string) -> LATENCY
```

In order to query against this data while filtering by timestamp range, the following mirror of the list is being maintained:

*Sorted state timestamps*

```text
ENTITY:CHECK:sorted_state_timestamps (sorted set) -> (TIMESTAMP, TIMESTAMP; TIMESTAP, TIMESTAMP; ...)
```

### Storing all action events

```text
ENTITY:CHECK:actions (hash) -> { TIMESTAMP => STATE }

STATE (string) - eg 'acknowledgement'
```

### Failed checks

*All failing checks*

    failed_checks (sorted set) -> ( TIMESTAMP, ENTITY:CHECK ; TIMESTAMP, ENTITY:CHECK ; ... )

### Current checks and entities

Any time an event is received from the check execution system for a check, the check's timestamp (rank) is updated in the sorted set for the entity. If a check isn't in this list, then it should be considered as old and irrelevant and a candidate for deletion, so hidden from general view in the API and Web UI, etc.

Related to this is the current_entities sorted set, which contains all entities that have current checks, ordered by the timestamp of the latest check event received for each entity.

    current_checks:ENTITY (sorted set) => ( TIMESTAMP, CHECK ; TIMESTAMP, CHECK ; ... )
    current_entities (sorted set) => ( TIMESTAMP, ENTITY ; TIMESTAMP, ENTITY ; ... )

### Unscheduled Maintenance

This key will only be present during the unschedule maintenance period for quick lookup of whether a service is in unschedule maintenance. An expiry TTL will be put on the key so it automatically goes away (default 4 hrs expiry time).

*Current state*
```text
ENTITY:CHECK:unscheduled_maintenance (string with expiry) -> TIMESTAMP

TIMESTAMP - the time the unscheduled maintenance begun
```

*Collect all unscheduled outages for reporting etc*
```text
ENTITY:CHECK:unscheduled_maintenances             (ordered set) -> ( DURATION, TIMESTAMP;
                                                                     DURATION, TIMESTAMP; ... )
ENTITY:CHECK:TIMESTAMP:unscheduled_maintenance:summary (string) -> SUMMARY

TIMESTAMP - start of the unscheduled maintenance period
DURATION  - the elapsed time of the unscheduled maintenance (including any extensions to the original period)
SUMMARY   - populated from the summary of the acknowledgement(s) (summaries to be glued together if there are
            multiple during an unscheduled outage)
```

In order to query against this data while filtering by timestamp range, the following mirror of the above sorted set is being maintained:

*Sorted unscheduled maintenance timestamps*
```text
ENTITY:CHECK:sorted_unscheduled_maintenance_timestamps (ordered set) -> ( TIMESTAMP, TIMESTAMP;
                                                                          TIMESTAMP, TIMESTAMP; ... )
```

### Scheduled Maintenance

This key will only be present during the scheduled maintenance period for quick lookup of whether a check is in scheduled maintenance. An expiry TTL (4 hours by default) will be put on the key so it destroys itself after this time.

*Current state*
```text
ENTITY:CHECK:scheduled_maintenance (string with expiry) -> TIMESTAMP

TIMESTAMP - the time the scheduled maintenance begun
```

*All future scheduled outages, and left for reporting purposes*
```text
ENTITY:CHECK:scheduled_maintenances (ordered set)             -> ( DURATION, TIMESTAMP;
                                                                   DURATION, TIMESTAMP; ... )
ENTITY:CHECK:TIMESTAMP:scheduled_maintenance:summary (string) -> SUMMARY

TIMESTAMP - start of the scheduled maintenance period
DURATION  - the elapsed time of the scheduled maintenance window (including any extensions to the original period)
SUMMARY   - populated from the summary of the scheduled maintenance creation event(s) (summaries to be glued
            together if there are multiple)
```

In order to query against this data while filtering by timestamp range, the following mirror of the above sorted set is being maintained:

*Sorted scheduled maintenance timestamps*
```text
ENTITY:CHECK:sorted_scheduled_maintenance_timestamps (ordered set) -> ( TIMESTAMP, TIMESTAMP;
                                                                        TIMESTAMP, TIMESTAMP; ... )

TIMESTAMP - start of the scheduled maintenance period (duplicated, in both the score and value of each
            item in the ordered set)
```

### Notifications

We need to store notifications that have been generated (not necessarily sent out, see Alerts), for problems, recoveries, and acknowledgements.

*Last alert of each type (problem, recovery, acknowledgement)*
```text
ENTITY:CHECK:last_problem_notification         (string) -> TIMESTAMP
ENTITY:CHECK:last_unknown_notification         (string) -> TIMESTAMP
ENTITY:CHECK:last_warning_notification         (string) -> TIMESTAMP
ENTITY:CHECK:last_critical_notification        (string) -> TIMESTAMP
ENTITY:CHECK:last_recovery_notification        (string) -> TIMESTAMP
ENTITY:CHECK:last_acknowledgement_notification (string) -> TIMESTAMP

TIMESTAMP - the time of the last notification sent of the corresponding type (problem, recovery, acknowledgement)
```

*Retention of all notifications*
```text
ENTITY:CHECK:problem_notifications         (list) -> [ TIMESTAMP, TIMESTAMP, ... ]
ENTITY:CHECK:unknown_notifications         (list) -> [ TIMESTAMP, TIMESTAMP, ... ]
ENTITY:CHECK:warning_notifications         (list) -> [ TIMESTAMP, TIMESTAMP, ... ]
ENTITY:CHECK:critical_notifications        (list) -> [ TIMESTAMP, TIMESTAMP, ... ]
ENTITY:CHECK:recovery_notifications        (list) -> [ TIMESTAMP, TIMESTAMP, ... ]
ENTITY:CHECK:acknowledgement_notifications (list) -> [ TIMESTAMP, TIMESTAMP, ... ]
```

### Alerts

Alerts correspond to messages that get emitted by Flapjack. A 'notification' may result in 0 or more alerts being sent out, depending on notification rules and intervals configured on the contacts for the check in question.

```text
drop_alerts_for_contact:CONTACT_ID                          (string with expiry) -> DURATION
drop_alerts_for_contact:CONTACT_ID:MEDIA                    (string with expiry) -> DURATION
drop_alerts_for_contact:CONTACT_ID:MEDIA:ENTITY:CHECK       (string with expiry) -> DURATION
drop_alerts_for_contact:CONTACT_ID:MEDIA:ENTITY:CHECK:STATE (string with expiry) -> DURATION
drop_rollup_alerts_for_contact:CONTACT_ID:MEDIA             (string with expiry) -> DURATION

# Vapourware warning: the alerts and alerts_by_* data structures are in the design phase and as yet
unimplemented. Work being tracked in gh-182 ... This data structure will change as it is not time
bucketed, and needs to be (for ease of aging out old data)

alerts                                                     (sorted set) -> [ TIMESTAMP, ALERT_ID; TIMESTAMP, ALERT_ID; ... ]

alerts_by_contact:CONTACT_ID                               (sorted set) -> [ TIMESTAMP, ALERT_ID; TIMESTAMP, ALERT_ID; ... ]
alerts_by_contact:CONTACT_ID:MEDIA                         (sorted set) -> [ TIMESTAMP, ALERT_ID; TIMESTAMP, ALERT_ID; ... ]
alerts_by_contact:CONTACT_ID:MEDIA:ENTITY:CHECK *          (sorted set) -> [ TIMESTAMP, ALERT_ID; TIMESTAMP, ALERT_ID; ... ]
alerts_by_contact:CONTACT_ID:MEDIA:ENTITY:CHECK:STATE *    (sorted set) -> [ TIMESTAMP, ALERT_ID; TIMESTAMP, ALERT_ID; ... ]

alerts_by_entity:ENTITY *                                  (sorted set) -> [ TIMESTAMP, ALERT_ID; TIMESTAMP, ALERT_ID; ... ]

alerts_by_check:ENTITY:CHECK                               (sorted set) -> [ TIMESTAMP, ALERT_ID; TIMESTAMP, ALERT_ID; ... ]
alerts_by_check:ENTITY:CHECK:CONTACT_ID *                  (sorted set) -> [ TIMESTAMP, ALERT_ID; TIMESTAMP, ALERT_ID; ... ]
alerts_by_check:ENTITY:CHECK:CONTACT_ID:MEDIA *            (sorted set) -> [ TIMESTAMP, ALERT_ID; TIMESTAMP, ALERT_ID; ... ]
alerts_by_check:ENTITY:CHECK:CONTACT_ID:MEDIA:STATE *      (sorted set) -> [ TIMESTAMP, ALERT_ID; TIMESTAMP, ALERT_ID; ... ]

alerts_by_time:DATE       (sorted set) -> [ TIMESTAMP, ALERT_ID; TIMESTAMP, ALERT_ID; ... ]
alerts_by_time:DATE:HH *  (sorted set) -> [ TIMESTAMP, ALERT_ID; TIMESTAMP, ALERT_ID; ... ]

alert:ALERT_ID  (hash) -> { timestamp => TIMESTAMP,
                            contact   => CONTACT_ID,
                            media     => MEDIA,
                            address   => ADDRESS,
                            check     => ENTITY:CHECK,
                            type      => NOTIFICATION_TYPE,
                            rollup    => ROLLUP_TYPE,
                            state     => STATE,
                            subject   => SUBJECT,
                            body      => BODY, }

ALERT_ID    - unique identifier for the alert (UUID?)
DATE        - date string of the form YYYYMMDD
HOUR        - 2 character string representing the hour, eg '00', '01', ... '23'
*           - this key type is probably overkill
SUBJECT     - for email alerts, the subject
BODY        - for email alerts, the body of the email message. for sms, pagerduty, jabber, the whole message content.
ROLLUP_TYPE - one of nil, 'problem' or 'recovery'. A recovery rollup alert is where the rollup is ending due to
              the number of alerting events falling below the rollup threshold

```

### Contacts

Contacts are populated from an external system via REST API or the flapjack-populator command line utility. See IMPORTING.

```text
contact:CONTACT_ID           (hash) -> { 'first_name' => FIRST_NAME,
                                         'last_name'  => LAST_NAME,
                                         'email'      => EMAIL }
contact_media:CONTACT_ID     (hash) -> { 'email'     => EMAIL,
                                         'sms'       => PHONE_NUMBER,
                                         'jabber'    => JABBER_ID,
                                         'pagerduty' => PAGERDUTY_SERVICE_KEY }
contact_tz:CONTACT_ID      (string) -> TIMEZONE
contact_media_intervals:CONTACT_ID  -> { 'email'     => INTERVAL,
                             (hash)      'sms'       => INTERVAL,
                                         'jabber'    => INTERVAL,
                                         'pagerduty' => INTERVAL }
contact_media_rollup_thresholds:CONTACT_ID -> {
                             (hash)      'email'     => FAILURE_COUNT,
                                         'sms'       => FAILURE_COUNT,
                                         'jabber'    => FAILURE_COUNT,
                                         'pagerduty' => FAILURE_COUNT }
contact_pagerduty:CONTACT_ID (hash) -> { 'subdomain' => PAGERDUTY_SUBDOMAIN,
                                         'username'  => PAGERDUTY_USERNAME,
                                         'password'  => PAGERDUTY_PASSWORD }
contact_tag:TAG               (set) -> ( CONTACT_ID, CONTACT_ID, ...)

CONTACT_ID            (string) - an external reference / identifier for this contact (used for synchronisation)
INTERVAL              (string) - number of seconds in between repeat alerts
PHONE_NUMBER          (string) - a phone number in international format, starting with +
JABBER_ID             (string) - the jabber id of the contact, eg 'adalovelace@jabber.charlesbabbage.com',
                                 can be a group chat
PAGERDUTY_SERVICE_KEY (string) - the API key for PagerDuty's integration API, corresponds to a 'service'
                                 within this contact's PagerDuty account
PAGERDUTY_SUBDOMAIN   (string) - the subdomain for this contact's PagerDuty account, eg "foobar" in the case
                                 of https://foobar.pagerduty.com/
PAGERDUTY_USERNAME    (string) - the username for the PagerDuty REST API (basic http auth) for reading data
                                 back out of PagerDuty
PAGERDUTY_PASSWORD    (string) - the password for the PagerDuty REST API
TAG                   (string) - arbitrary tag
TIMEZONE              (string) - a timezone string representing the user's local timezone, eg 'Australia/Broken_Hill'
                                 see: http://www.twinsun.com/tz/tz-link.htm, http://tzinfo.rubyforge.org/doc/,
                                 http://api.rubyonrails.org/classes/ActiveSupport/TimeZone.html
FAILURE_COUNT         (string) - the number of failing checks this contact has before rollup kicks in, 0 means never
```

Notes:

- `contact:CONTACT_ID` is about the contact, `contac_media:CONTACT_ID` lists which contact methods to use
  for this contact (so if it just contains sms then we'll only notify this person by sms).
- `EMAIL` ... note that this is potentially duplicated, the email field in `contact:CONTACT_ID` is really
  just for matching up users and is not used as a contact media
- `JABBER_ID` - may be a jabber id of an individual, or of a group chat room. If a group chat room this
  jabber_id should also be included in the flapjack configuration file so that flapjack jabber gateway joins
  the group chat

### Entity and Check Contacts

Which contacts are interested in which entities and/or which checks?

```text
contacts_for:ENTITY_ID       (set) -> ( CONTACT_ID, CONTACT_ID, ... )
contacts_for:ENTITY_ID:CHECK (set) -> ( CONTACT_ID, CONTACT_ID, ... )
entity:ENTITY_ID            (hash) -> { 'name' => ENTITY }
entity_id:ENTITY          (string) -> ENTITY_ID
entity_tag:TAG               (set) -> ( ENTITY_ID, ENTITY_ID, ... )

ENTITY_ID - a unique, immutable identifier given to each entity. This allows the name of the entity
            to change (eg a host gets renamed) and synchronisation to not go out of whack.
TAG       - arbitrary tag
```

### Notification Rules

A contact may have a set of notification rules to fine tune when, and by what means, they are notified.

```text
contact_notification_rules:CONTACT_ID (set) -> { RULE_ID }
notification_rule:RULE_ID (hash) -> {
                                      'contact_id'         => CONTACT_ID,
                                      'entity_tags'        => TAG_LIST,
                                      'entities'           => ENTITY_LIST,
                                      'time_restrictions'  => TIME_RESTRICTIONS,
                                      'unknown_media'      => MEDIA_LIST,
                                      'warning_media'      => MEDIA_LIST,
                                      'critical_media'     => MEDIA_LIST,
                                      'unknown_blackhole'  => BOOLEAN,
                                      'warning_blackhole'  => BOOLEAN,
                                      'critical_blackhole' => BOOLEAN,
                                    }

TAG_LIST            (string, json) - array of tags
ENTITY_LIST         (string, json) - array of entities
TIME_RESTRICTIONS   (string, json) - array of TIME_RESTRICTIONs
MEDIA_LIST          (string, json) - array of medias eg ['email', 'sms']
BOOLEAN                   (string) - 'true' or 'false'

TIME_RESTRICTION (json hash) ->
      {
        "start_time": "TIME_ZONELESS",
        "end_time":   "TIME_ZONELESS",
        "rrules":     [ RRULE, RRULE, ... ],
        "exrules":    [ EXRULE, EXRULE, ... ],
        "rtimes":     [ RTIME, RTIME, ... ],
        "extimes":    [ EXTIME, EXTIME, ... ]
      }

TIME_ZONELESS - time string with no timezone or UTF offset information (taken to be
  in the contact's configured timezone, or the configured default contact timezone),
  format: YYYY-MM-DD HH:MM:SS eg "2013-04-18 15:00:00". Used to represent the start
  and end time of the FIRST OCCURRANCE of the repeating time period.
RRULE - See the ice_cube documentation and the iCal specification for details. Here's an example of an RRULE:
          {
            "validations": {
              "day": [1,2,3,4,5]
            },
            "rule_type": "Weekly",
            "interval": 1,
            "week_start": 0
          }
EXRULE, RTIME, EXTIME - See the ice_cube documentation and the iCal specification for details.
```
Notes
* TIME_RESTRICTION is a hash representation of an RFC 2445 iCalendar schedule. It is the same format accepted by the flapjack API. When acting on the time restrictions within a notification rule, flapjack modifies the format of the hash to be compatible with [ice_cube](https://github.com/seejohnrun/ice_cube)'s hash format before instantiating an IceCube::Schedule object to operate on.

### Alerting Checks per Contact Media

We keep track of which failing checks are alerting for each contact's media, for rollup initially but should provide a useful and fast view for users into which failing checks they are being alerted for.

```text
contact_alerting_checks:CONTACT_ID:media:MEDIA (sorted set) -> ( TIMESTAMP, ENTITY:CHECK ; ... )
```

### Event processor statistics

The following counters are incremented during event processing so we can see how many events flapjack is processing, and of which types.

```text
event_counters (hash) -> { all => COUNTER, ok => COUNTER, failure => COUNTER, action => COUNTER }

COUNTER - incrementing integer counter, reset to zero when the event processor boots
```

"The range of values supported by HINCRBY is limited to 64 bit signed integers." So up to 9,223,372,036,854,775,807. I guess we'll need to reset it on occasion - at midnight perhaps. But if we're getting that many events during a run of flapjack-executive then we probably have other problems...

To support multiple concurrent executive instances:

```text
executive_instance:HOSTIDENT:PID (hash) -> { boot_time => BOOTTIME }
event_counters:HOSTIDENT:PID     (hash) -> { all => COUNTER, ok => COUNTER, failure => COUNTER,
                                                    action => COUNTER }
```

