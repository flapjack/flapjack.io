Flapjack follows the version numbering conventions as set out in the [Semantic Versioning 2.0](http://semver.org/spec/v2.0.0.html) specification. Specifically: 

> Given a version number MAJOR.MINOR.PATCH, increment the:
> 
> * MAJOR version when you make incompatible API changes,
> * MINOR version when you add functionality in a backwards-compatible manner, and
> * PATCH version when you make backwards-compatible bug fixes.
> 
> Additional labels for pre-release and build metadata are available as extensions to the MAJOR.MINOR.PATCH format.

### How features + bug fixes get into releases

* New issues are created, and discussion ensues in the issue's comments
* We don't initially allocate a milestone to an issue
* Issues without milestones are triaged in release planning meetings
* Release planning meetings are held publicly on Google Hangouts, and will be announced in advance.

The outcomes for release planning meetings are:

* Issues without milestones are allocate a milestone
* Issues are allocated to the next MINOR release 
* A release plan is published to the [Flapjack wiki](https://github.com/flpjck/flapjack/wiki/pages) in the format "Release plan for \<MAJOR.MINOR\>"

### Bug policy

Bugs are swept under the carpet in many open source projects. Flapjack has a clear policy for how we deal with bugs: 

* For bugs triaged as **easy**, we try to fix + release in a PATCH release
* For bugs triaged as **medium**, we try fix slot them into the next MINOR release
* For bugs triaged as **hard**, we try and slot them into the next MAJOR release