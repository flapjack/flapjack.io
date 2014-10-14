## What could we deliver in Flapjack 2.0?

 * Original idea: parity with 1.x, but with better internals
 * Recently: data model changes including: 
   * Removing entities
   * Implement relationships with tags
   * Rework how notifications are generated (more Redis, less Ruby)
 * Do we use different technologies for the message bus? Kafka?
 * Do we implement different data storage technology for history? InfluxDB?
 * Remove daemonisation code, use a Golang wrapper, or systemd.
 * GUI improvements:
   * Pagination
   * Finish off contact management
   * Searching
 * Split out web interface into a separate RubyGem.
 * Re-implement the web app to talk to the API directly?
 * Documentation on how notification rules + tags + groups of contacts work in Flapjack 2.0
 * RPMs + full Red Hat support, with a Yum repository
 * Configurable states - moving beyond OK, WARNING, CRITICAL, UNKNOWN
 * Notification rule support for configurable states
 * Ability to source extra data on alerts, like nagios-herald
 * Formalisation around how the gateways work
 * Unification of media gateways (e.g. multiple gateways talking to single queue, or separate gateway plugins for different SMS providers)
 * Parenting...

At a high level, deliverables fit into three categories:

 * Architecture
 * Features (some with architectural dependencies)
 * Release

## What are we delivering for Flapjack 2.0?

Background:

* There are features above that might be delayable to 2.x series minor releases
* If we can implement the backwards incompatible changes for 2.0, we have a solid platform for shipping these features in 2.x
* There’s a risk that we would need to introduce backwards incompatible changes that we didn’t anticipate to deliver these features 
* 1.0 took a long time to ship - 9 months delayed
* We all feel pretty average about the delivery time
* We want to ship faster in the future
* There was scope creep.
* Scope creep is inescapable in any project of sufficient complexity
* We can aggressively limit the scope to ship quicker
* Do this buy only attacking architectural deliverables, and minimal release deliverables

### Outcomes

Make Flapjack platform changes to: 

* Make it easier to add features
* Make it easier to optimise performance

### What are the architectural deliverables we need to ship?

* Data model changes:
  * Removing entities
  * Implement relationships with tags
  * Rework how notifications are generated (more Redis, less Ruby)
* Sandstorm as the Redis ORM
* Richer tagging support:
  * Tags as top level objects (can query intersections, relationships, do JOIN like operations)
  * Tag namespacing - some reserved namespaces (like entity:)
  * Contact grouping 
  * Entity grouping

### What have we currently broken with these architectural changes?

* Web interface
* API?
* Grouping of checks around entities (there are no entities)
  * We can re-add these with tags
  * Multi-tenancy - restricting tags returned to a client. 
  * Tag (entity:foo,entity:bar) -> checks with this tag -> all other tags on those checks
  * Gateways
    * How do they handle lack of entities? Tags.

We need to review almost every line of the code for Flapjack 2.0. 

### What have we done already?

As of 2014/10/14, we have implemented these data model changes:

 * Removing entities
 * Implement relationships with tags
 * Rework how notifications are generated (more Redis, less Ruby)
 * Sandstorm as the Redis ORM

### What do we need to do to ship Flapjack 2.0?

> “Do all the damage we’re going to do before starting to repair.”

In order of priority:

API:

* Pagination

Tags:

 * Collect use cases for tagging
   * Rollup
   * Multi-tenancy
   * Gateways
   * Web interface
   * API querying (e.g. get a list of all entities that have active checks, i.e. not disabled, would query /checks endpoint with tags + disabled parameter)
 * Define what the scope of the tagging changes will be
 * Implement tagging changes
 * Define policy around tagging

Search:

 * Contacts
 * Checks
 * Tags

Web: 

 * Fix broken features where possible.
 * Drop features where it’s too hard.

Start a separate project for the web interface post 2.0 release.

#### Maybes

Channels (Do we delay this until 3.0? Can we wait until a minor release?):

 * High level routing for groups of people (teams, departments, companies)
 * Currently sites who want to use Flapjack for multi-tenancy require some external source of truth to handle the complex mappings between contacts and entities/checks.
 * Channels would be a helpful accelerator for multi-tenant cases. 


