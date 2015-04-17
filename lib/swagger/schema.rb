class Schema < ERB
  def initialize
    swagger_dir = File.dirname(__FILE__)
    template_path = File.join(swagger_dir, 'schema.html.erb')
    super(File.read(template_path), nil, '-')
  end

  def result(options = {})
    b = binding
    [:definitions, :definition].each do |v|
      b.local_variable_set(v, options[v])
    end
    super(b)
  end
end