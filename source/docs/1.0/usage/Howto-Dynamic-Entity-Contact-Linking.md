# Howto: Dynamic linking of Contacts using the 'ALL' entity hack

Flapjack 0.x and 1.x have a requirement that contacts must be explicity linked to entities in order for any notifications about checks on the entity to go to the contact. This is too restrictive for some sites and means it's much harder to use Flapjack for alerting of environments where hosts come and go without configuration management ceremony, eg in autoscaling groups.

Sean Porter contributed a neat workaround for this situation which involves creation of a special entity with an ID of 'ALL'.
This entity doesn't correspond to any one entity but rather collects together all entities for the purposes of assigning contacts. Contacts can then be linked to this entity, and they'll then be able to receive notifications for any entity.

Notification rules are then used to refine which notifications are sent to each contact.

## Example using flapjack-diner and the JSON API

Ensure the ALL entity exists:

```ruby
#!/usr/bin/env ruby

require 'flapjack-diner'
Flapjack::Diner.base_uri('127.0.0.1:3081')

entity_all_data = {
  :id   => 'ALL',
  :name => 'ALL'
}

unless Flapjack::Diner.entities(entity_all_data[:id])
  puts "Creating entity: ALL"
  Flapjack::Diner.create_entities([entity_all_data])
end
```

Ensure Ada exists and is a contact on the ALL entity

```ruby
require 'flapjack-diner'
Flapjack::Diner.base_uri('127.0.0.1:3081')

# Create contact Ada if she doesn't already exist

ada_data = {
  :id         => '8d5fd668-b4c4-481b-84be-9db4e5910110',
  :first_name => 'Ada',
  :last_name  => 'Lovelace',
  :email      => 'ada@example'
}

unless Flapjack::Diner.contacts(ada_data[:id])
  puts "Creating contact: Ada"
  Flapjack::Diner.create_contacts([ada_data])
end

# Assign a mobile number to Ada for SMS via Twilio

medium = {
  :type => 'sms_twilio',
  :address => '+61444444444',
  :interval => 1,
  :rollup_threshold => 3
}
ada = Flapjack::Diner.contacts(ada_data[:id]).first
if ada[:links][:media].empty?
  puts "Creating Ada's media"
  Flapjack::Diner.create_contact_media(ada_data[:id], [medium])
end
ada = Flapjack::Diner.contacts(ada_data[:id]).first

# Add Ada to the ALL entity

entity_all = Flapjack::Diner.entities(entity_all_data[:id]).first
unless entity_all[:links][:contacts].include?(ada_data[:id])
  puts "Adding Ada to the ALL entity"
  Flapjack::Diner.update_entities(entity_all_data[:id], :add_contact => ada_data[:id])
end
```

Assuming the sms_twilio gateway is configured, Ada will now receive SMS notifications for any problem detected by Flapjack on any entity. Notification Rules can be used to filter out un-interesting notificaitons, matching on entity name, domain name, words in the check description, on entity tags, etc etc.

