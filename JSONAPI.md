# JSON API

This API is moving towards compliance with the [jsonapi specification](http://jsonapi.org/format).

Work is being tracked in [#396](https://github.com/flpjck/flapjack/issues/396) and linked issues.

**WARNING: The JSON API is currently still a work in progress so it is changing a lot at the moment.**

Flapjack's JSON HTTP API currently provides the following queries, data import functions and actions:


* [Contacts](jsonapi-contacts)
* [Media](jsonapi-media)
* [Notification Rules](jsonapi-notification_rules)
* [Miscellaneous](jsonapi-miscellaneous)
* [Entities](jsonapi-entities)
* [Checks](jsonapi-checks)
* [Status](jsonapi-status) (plus Maintenances, Acknowledgements, Outages)
* [Test Notifications](jsonapi-test)


See also the [flapjack-diner](https://github.com/flpjck/flapjack-diner/) gem which provides a ruby consumer of this API.

## Query Paramaters

Some of the GET queries can take some optional query string parameters as follows:

<table>
  <tr>
    <th>parameter</th>
    <th>description</th>
  </tr>
  <tr>
    <td>start_time</td>
    <td>start time of the period in ISO 8601 format, eg 2013-02-22T15:39:39+11:00. Absence means 'beginning of time'.</td>
  </tr>
  <tr>
    <td>end_time</td>
    <td>end time of the period in ISO 8601 format. Absence means 'end of days'.</td>
  </tr>
</table>

These five GET queries:

<ul>
  <li><a href="#get_status">GET /status[/ENTITY[/CHECK]]</a></li>
  <li><a href="#get_outages">GET /outages[/ENTITY[/CHECK]]</a></li>
  <li><a href="#get_unscheduled_maintenances">GET /unscheduled_maintenances[/ENTITY[/CHECK]]</a></li>
  <li><a href="#get_scheduled_maintenances">GET /scheduled_maintenances[/ENTITY[/CHECK]]</a></li>
  <li><a href="#get_downtime">GET /downtime[/ENTITY[/CHECK]]</a></li>
</ul>

take ENTITY and CHECK strings as part of the URL for backwards compatibility; they
also offer a more flexible parameter scheme by which the data for multiple entities
and checks can be requested.

<table>
  <tr>
    <th>parameter</th>
    <th>description</th>
  </tr>
  <tr>
    <td>entity / entity[]</td>
    <td>Request the data for all the checks from one entity (e.g. ``/status?entity=ENTITY``) or from multiple entities (e.g. ``/status?entity[]=ENTITY1&entity[]=ENTITY2``)</td>
  </tr>
  <tr>
    <td>check[ENTITY]</td>
    <td>Request the data for a single check from an entity (e.g. ``/status?check[ENTITY]=CHECK``), multiple checks from a single entity (e.g. ``/status?check[ENTITY]=CHECK1&check[ENTITY]=CHECK2``), or multiple checks from different entities (e.g. ``/status?check[ENTITY1]=CHECK1&check[ENTITY2]=CHECK2``).
      <br>
      <br>
      Also note that this can be combined with the entity parameters: ``/status?entity=ENTITY1&check[ENTITY2]=CHECK`` is a valid query.
    </td>
  </tr>
</table>

The corresponding POST/DELETE methods take a similar parameter set, but the
data is expressed as encoded form parameters, or serialized as JSON, etc.

---
