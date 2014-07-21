### Live demo website:
* Integrate with Jabber (GTalk?)
* Send emails
* Add some default data

### Vagrant box:
* This will be easier if we produce packages with Omnibus

### A comparison matrix:
* List different monitoring systems
* Help people compare Flapjack to other existing tools
* Include this on the Flapjack website
* Put a Venn diagram explaining the overlap of features

### Draft comparison matrix

| Feature                              | Flapjack       | Nagios         | 
|--------------------------------------|----------------|----------------|
| Talk to jabber                       | y              | y (via plugin) |
| Talk to PagerDuty                    | y              | y (via plugin) |
| Escalations                          | n              | y              |
| Time of day notifications            | y              | y              |
| API for managing contacts            | y              | n              |
| API for scheduling maintenance       | y              | n              |
| On-the-fly config changes            | y              | n              |
| Parenting                            | n              | y              |
| Executes checks                      | n              | y              |
| Accepts arbitrary check results      | y              | n              |
| Out-of-band verification             | y              | n              |
| Freshness checks                     | n              | y              |
| Muted notifications for new checks   | y              | y              |
| License                              | MIT            | GPLv2          |
| Horizontally scalable                | y              | n              |
| State storage backend                | Redis          | Flat file      |
| Web interface                        | y              | y              |
| Edit configuration via web interface | n              | n              |
| Live search                          | n              | y              |
| SLA Reports                          | y              | y (via plugin) |
