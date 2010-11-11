def link_image(name,hash_totals)
  "<a href='/graphs/#{name.capitalize}/#{hash_totals[:piedad]}/#{hash_totals[:jojoy]}/#{hash_totals[:reyes]}'> #{name.capitalize} </a>"
end
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
