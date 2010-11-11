require 'erb'
require 'tilt'
module Template
  def self.included(base)
    base.extend(ClassMethods)
  end
  module ClassMethods
    def erb(view)
      Tilt.register 'html.erb', Tilt::ERBTemplate
      view = "views/#{view}.html.erb"
      unless File.file? view
        raise Exception.new("#{view} is not defined")
      end
      html = ERB.new(File.read(view))
      html.result(binding)
    end

    def htmlize(content,layout = "layout/application")
      Tilt.register 'html.erb', Tilt::ERBTemplate
      layout = "views/#{layout}.html.erb"
      html = Tilt.new(layout)
      html.render {content}
    end
  end
end
