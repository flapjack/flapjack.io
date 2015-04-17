
# currently here for debugging -- should package this up to be called from
# separate script or the slate template itself

require 'forwardable'
require 'swagger'
require 'erb'

require File.join(File.dirname(__FILE__), 'jsonapi_method.rb')
require File.join(File.dirname(__FILE__), 'parameters.rb')
require File.join(File.dirname(__FILE__), 'schema.rb')

swagger_dir = File.dirname(__FILE__)
swagger = Swagger.load(File.join(swagger_dir, 'api.json'))

method_template = JsonapiMethod.new

output = ""

resources = {
  'checks'   => 'check',
  'contacts' => 'contact',
  'media'    => 'medium',
  'rules'    => 'rule',
  'scheduled_maintenances' => 'scheduled_maintenance',
  'tags'     => 'tag',
  'unscheduled_maintenances' => 'unscheduled_maintenances'
}

resources.keys.each do |resource|

  path        = "/#{resource}"
  single_path = "/#{resource}/{#{resources[resource]}_id}"

  [:post, :get, :patch, :delete].each do |method|
    unless :post.eql?(method)
      if swagger.paths.has_key?(single_path)
        swagger_path = swagger.paths[single_path]
        if swagger_path.has_key?(method)
          output << method_template.result(
            :title       => "#{method.to_s.upcase} #{single_path}",
            :operation   => swagger_path.send(method),
            :definitions => swagger.definitions
          )
          output << "\n\n"
        end
      end
    end

    if swagger.paths.has_key?(path)
      swagger_path = swagger.paths[path]
      if swagger_path.has_key?(method)
        output << method_template.result(
          :title       => "#{method.to_s.upcase} #{single_path}",
          :operation => swagger_path.send(method),
          :definitions => swagger.definitions
        )
        output << "\n\n"
      end
    end

    ((resources.values - [resources[resource]]) + (resources.keys - [resource])).each do |other_resource|
      link_path = :get.eql?(:method) ? "/#{resource}/{#{resources[resource]}_id}/#{other_resource}" :
                                       "/#{resource}/{#{resources[resource]}_id}/links/#{other_resource}"

      if swagger.paths.has_key?(link_path)

        swagger_path = swagger.paths[link_path]
        if swagger_path.has_key?(method)
          output << method_template.result(
            :title       => "#{method.to_s.upcase} #{link_path}",
            :operation   => swagger_path.send(method),
            :definitions => swagger.definitions
          )
          output << "\n\n"
        end
      end

    end

  end

end

puts output
