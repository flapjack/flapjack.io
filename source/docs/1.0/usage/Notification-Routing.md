## Notification routing

The animation below shows graphically how events are turned into
notifications, and how notifications are routed to contacts. Further down, you
can find a step-by-step description of routing:

![notification routing](/images/notification-routing.gif)

## Details

1. **Find failing events**. The event is discarded if ANY of the following are true:
     * new check state is Ok
     * entity/check is in scheduled or unscheduled maintenance
     * current state duration for entity/check is less than the `initial_failure_delay` (default 30 sec, can be specified in the incoming event)
     * time elapsed since last notification is less than `repeat_failure_delay` (default 60 sec, can be specified in the incoming event)

2. **Find contacts interested in entity**
     * Includes all the  [Contacts](/docs/1.0/jsonapi#contacts) listed in the event [Entity](/docs/1.0/jsonapi#entities)
     * Includes all the contacts listed in the special entity with id 
       [ALL](/docs/1.0/usage/Howto-Dynamic-Entity-Contact-Linking)

3. **For each contact**
  3. **Find the subset of applicable contact notification rules based on tags, severity,
     time of day**. Starting with all the
     [Notification Rules](/docs/1.0/jsonapi#notification-rules) for the contact,
     we find those for which **all** of the following are true:
      * Each `tag` in the rule is among the event tags. Note that
        an event has two tags added automatically: the entity name, and the
        check name.
      * Each `regex_tag` in the rule matches at least one of the event tags.
      * The rule has no `entities`, or the event entity is among the rule `entities`.
      * Each `regex_entity` matches the event entity.
      * At least one of the rule `time_restrictions` matches the event time.
  
  4. **Skip notification based on blackhole notification rules**.
      * If any of the applicable contact notification rules found at previous step contains
         `xxx_blackhole == true`, for the current event state `xxx`, we do not notify
         the current contact.
  
  5. **Find the notifiable media types for the contact based on notification rules**.
      * From the applicable contact notification rules found at previous step, get the
         set of media types listed in the rules `xxx_media`, for the current event
         state `xxx`.
      * If there are no notifiable media types, we do not notify the current contact.
     
  6. **Discard the media types based on media notification intervals**.
     * From the list of media types found at previous step, discard those
       for which an alert has been sent for the current contact-entity-check
       combination in the last media `interval`.

#### Creating the above animation

1. Export [architecture diagrams](/images/FlapjackArchitecture.key) to PNG
2. Run this shell:

``` bash
for f in *.png ; do convert $f $(basename $f .png).gif ; done
gifsicle --delay=200 --loop *.gif > anim.gif
```
