
# temporary hack -- will be integrated into the slate docs soon

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
        if swagger_path.respond_to?(method)
          output << method_template.result(
            :operation   => swagger_path.send(method),
            :definitions => swagger.definitions
          )
          output << "\n\n"
        end
      end
    end

    if swagger.paths.has_key?(path)
      swagger_path = swagger.paths[path]
      if swagger_path.respond_to?(method)
        output << method_template.result(
          :operation => swagger_path.send(method),
          :definitions => swagger.definitions
        )
        output << "\n\n"
      end
    end
  end

end

puts output
