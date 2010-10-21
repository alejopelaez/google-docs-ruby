class Routes < Array
    def add(method, path, options=nil, &action)
        self << Route.new(method,path,options,&action)
    end

    # Este metodo mira si una ruta dada coinide con alguna  
    # de las rutas internas.
    # Retorna la primer ruta que haga match.
    def math(method, path)
        return nil if self.empty?
        method = method.to_s.downcase.strip.to_sym
        routes = self.select{|i| i.method = method}
        pahts = routes.map{|i| i.path}
        path, values = Router.match(path,paths)
    end
end

class Route
    attr_accessor :pattern,:options,:action

    def initialize(method, path, options, &action)
        @pattern = Pattern.new(metodo,path)
        @options = options
        @action = action
    end

end

# Clase que representa un patron de la forma
# metodo /static1/static2/.../staticn/:opt1/:opt2...
# Tiene la capacidad de hacer math con un path concreto
# y devolver los parametros.
class Pattern
    attr_accessor :method, :path
    def initialize(method, path)
        
    end
end

# Clase encargada de hacer el mathing entre una ruta
# y una lista de rutas.
# Ademas retorna los valores encontrados.
class Router
    def self.match(path,paths)
        
    end

    def static_match
    end

    def values_mathc
    end
end

# Clase que representa una uri, contiene las partes y
# la extension del recurso solicitado.
class Path
end

end
