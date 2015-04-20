#!/usr/bin/env ruby

require 'forwardable'
require 'swagger'
require 'erb'

require File.join(File.dirname(__FILE__), 'jsonapi_method.rb')
require File.join(File.dirname(__FILE__), 'parameters.rb')
require File.join(File.dirname(__FILE__), 'schema.rb')

class SwagHTML
  def initialize
    swagger_dir = File.dirname(__FILE__)
    @swagger = Swagger.load(File.join(swagger_dir, 'api.json'))
  end

  def swagger_method(method_type, path)
    method_template = JsonapiMethod.new
    output = ""
    if @swagger.paths.has_key?(path)
      swagger_path = @swagger.paths[path]
      if swagger_path.has_key?(method_type)
        output << method_template.result(
          :title       => "#{method_type.to_s.upcase} #{path}",
          :operation   => swagger_path.send(method_type),
          :definitions => @swagger.definitions
        )
        output << "\n\n"
      end
    end
    output
  end
end
