require 'tilt'
require 'erb'
module Template
  
  def self.out(file, *args)
    Tilt.register 'html.erb', Tilt::ERBTemplate
    template = Tilt.new(file)
    template.render { args }
  end

    
end
