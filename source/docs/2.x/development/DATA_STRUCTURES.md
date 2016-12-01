Generated using `rake documentation:dump_keys` in the Flapjack codebase.

---


# Check

## global

```
check::attrs:ids (set)
check::indices:by_ack_hash (hash)
check::indices:by_alertable:* (set)
check::indices:by_enabled:* (set)
check::indices:by_failing:* (set)
check::indices:by_name (hash)
```

## instance

```
check:[UUID]:attrs (hash)
  {
    :id  => :string
    :name  => :string
    :enabled  => :boolean
    :ack_hash  => :string
    :initial_failure_delay  => :integer
    :repeat_failure_delay  => :integer
    :notification_count  => :integer
    :condition  => :string
    :failing  => :boolean
    :alertable  => :boolean
  }
check:[UUID]:assocs:alerts_ids (set)
check:[UUID]:assocs:has_one (hash)
check:[UUID]:assocs:latest_notifications_ids (sorted_set)
check:[UUID]:assocs:notifications_ids (set)
check:[UUID]:assocs:scheduled_maintenances_ids (sorted_set)
check:[UUID]:assocs:states_ids (sorted_set)
check:[UUID]:assocs:tags_ids (set)
check:[UUID]:assocs:unscheduled_maintenances_ids (sorted_set)
```

# Contact

## global

```
contact::attrs:ids (set)
contact::indices:by_name:* (set)
```

## instance

```
contact:[UUID]:attrs (hash)
  {
    :id  => :string
    :name  => :string
    :timezone  => :string
  }
contact:[UUID]:assocs:media_ids (set)
contact:[UUID]:assocs:rules_ids (set)
contact:[UUID]:assocs:tags_ids (set)
```

# Medium

## global

```
medium::attrs:ids (set)
medium::indices:by_transport:* (set)
```

## instance

```
medium:[UUID]:attrs (hash)
  {
    :id  => :string
    :transport  => :string
    :address  => :string
    :interval  => :integer
    :rollup_threshold  => :integer
    :pagerduty_subdomain  => :string
    :pagerduty_token  => :string
    :pagerduty_ack_duration  => :integer
    :last_rollup_type  => :string
  }
medium:[UUID]:assocs:alerts_ids (set)
medium:[UUID]:assocs:belongs_to (hash)
medium:[UUID]:assocs:rules_ids (set)
```

# Notification

## global

```
notification::attrs:ids (set)
```

## instance

```
notification:[UUID]:attrs (hash)
  {
    :id  => :string
    :severity  => :string
    :duration  => :integer
    :condition_duration  => :float
    :event_hash  => :string
  }
notification:[UUID]:assocs:belongs_to (hash)
notification:[UUID]:assocs:has_one (hash)
```

# Rule

## global

```
rule::attrs:ids (set)
rule::indices:by_blackhole:* (set)
rule::indices:by_conditions_list:* (set)
rule::indices:by_enabled:* (set)
rule::indices:by_has_media:* (set)
rule::indices:by_name:* (set)
rule::indices:by_strategy:* (set)
```

## instance

```
rule:[UUID]:attrs (hash)
  {
    :id  => :string
    :name  => :string
    :enabled  => :boolean
    :blackhole  => :boolean
    :strategy  => :string
    :conditions_list  => :string
    :has_media  => :boolean
    :time_restriction_ical  => :string
  }
rule:[UUID]:assocs:belongs_to (hash)
rule:[UUID]:assocs:media_ids (set)
rule:[UUID]:assocs:tags_ids (set)
```

# Scheduled maintenance

## global

```
scheduled_maintenance::attrs:ids (sorted_set)
scheduled_maintenance::indices:by_end_time (sorted_set)
scheduled_maintenance::indices:by_start_time (sorted_set)
```

## instance

```
scheduled_maintenance:[UUID]:attrs (hash)
  {
    :id  => :string
    :start_time  => :timestamp
    :end_time  => :timestamp
    :summary  => :string
  }
scheduled_maintenance:[UUID]:assocs:belongs_to (hash)
```

# State

## global

```
state::attrs:ids (sorted_set)
state::indices:by_action:* (set)
state::indices:by_condition:* (set)
state::indices:by_created_at (sorted_set)
```

## instance

```
state:[UUID]:attrs (hash)
  {
    :id  => :string
    :created_at  => :timestamp
    :updated_at  => :timestamp
    :condition  => :string
    :action  => :string
    :summary  => :string
    :details  => :string
    :perfdata_json  => :string
  }
state:[UUID]:assocs:belongs_to (hash)
state:[UUID]:assocs:latest_media_ids (set)
```

# Statistic

## global

```
statistic::attrs:ids (set)
statistic::indices:by_instance_name:* (set)
```

## instance

```
statistic:[UUID]:attrs (hash)
  {
    :id  => :string
    :instance_name  => :string
    :created_at  => :timestamp
    :all_events  => :integer
    :ok_events  => :integer
    :failure_events  => :integer
    :action_events  => :integer
    :invalid_events  => :integer
  }
```

# Tag

## global

```
tag::attrs:ids (set)
tag::indices:by_name (hash)
```

## instance

```
tag:[UUID]:attrs (hash)
  {
    :id  => :string
    :name  => :string
  }
tag:[UUID]:assocs:checks_ids (set)
tag:[UUID]:assocs:contacts_ids (set)
tag:[UUID]:assocs:rules_ids (set)
```

# Unscheduled maintenance

## global

```
unscheduled_maintenance::attrs:ids (sorted_set)
unscheduled_maintenance::indices:by_end_time (sorted_set)
unscheduled_maintenance::indices:by_start_time (sorted_set)
```

## instance

```
unscheduled_maintenance:[UUID]:attrs (hash)
  {
    :id  => :string
    :start_time  => :timestamp
    :end_time  => :timestamp
    :summary  => :string
  }
unscheduled_maintenance:[UUID]:assocs:belongs_to (hash)
```

