# Howto: Dynamic linking of Contacts using the 'ALL' entity hack

Flapjack 0.x and 1.x have a requirement that contacts must be explicity linked to entities in order for any notifications about checks on the entity to go to the contact. This is too restrictive for some sites and means it's much harder to use Flapjack for alerting of environments where hosts come and go without configuration management ceremony, eg in autoscaling groups.

Sean Porter contributed a neat ~~hack~~ workaround for this situation which involves creation of a special entity named 'ALL'. This entity doesn't correspond to any one entity but rather collects together all entities. Contacts can then be linked to this entity, and they'll then be able to receive notifications for any entity.

Then, notification rules can be used to refine which notifications are sent to each contact.



