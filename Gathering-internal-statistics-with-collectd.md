Here is an example configuration file: 

```
LoadPlugin "curl_json"

<Plugin curl_json>
  <URL "http://localhost:3080/self_stats.json">
    Instance "flapjack"

    # global stats
    <Key "events_queued">
      Type "gauge"
    </Key>
    <Key "all_entities">
      Type "gauge"
    </Key>
    <Key "failing_entities">
      Type "gauge"
    </Key>
    <Key "all_checks">
      Type "gauge"
    </Key>
    <Key "failing_checks">
      Type "gauge"
    </Key>
    <Key "total_keys">
      Type "gauge"
    </Key>

    # event processing stats
    <Key "processed_events/all_time/total">
      Type "derive"
    </Key>
    <Key "processed_events/all_time/ok">
      Type "derive"
    </Key>
    <Key "processed_events/all_time/failure">
      Type "derive"
    </Key>
    <Key "processed_events/all_time/action">
      Type "derive"
    </Key>
  </URL>
</Plugin>
```

An example graph:

![graph of failures detected by Flapjack](http://i.imgur.com/FZOdh8G.png)