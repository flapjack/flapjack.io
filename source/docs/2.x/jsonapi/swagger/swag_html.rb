
# temporary hack -- will be integrated into the slate docs soon

require 'forwardable'
require 'swagger'
require 'erb'

swagger_dir = File.dirname(__FILE__)

swagger = Swagger.load(File.join(swagger_dir, 'api.json'))

template_path = File.join(swagger_dir, 'method.html.erb')
template = ERB.new(File.read(template_path), nil, '-')

output = ""

[:get, :post, :patch, :delete].each do |method|

  ['/contacts'].each do |path|

    unless swagger.paths.has_key?(path)
      STDERR.puts "No path for #{path}"
      next
    end

    swagger_path = swagger.paths[path]

    next unless swagger_path.respond_to?(method)
    @operation = swagger_path.send(method)

    output << template.result(binding)

    output << "\n\n"
  end

end

puts output
