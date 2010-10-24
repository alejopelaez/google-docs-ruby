# Arreglo con todas las rutas
class Routes < Array
    def add(method, path, &action)
        self << Route.new(method,path,&action)
    end

    # Este metodo mira si una ruta dada coinide con alguna  
    # de las rutas internas.
    # Retorna la primer ruta que haga match.
    def match(method, path)
        return nil,nil if self.empty?
        method = method.to_s.downcase.strip.to_sym
        routes = self.select{|i| i.method == method}        
        against = Path.new path
        routes.each do |r|
            puts "---"
            puts against.parts
            puts r.path.parts
            res, vals = r.path.match? against
            return r, vals if res
        end
        return nil,nil
    end
end

class Route
    attr_accessor :path,:method,:action

    def initialize(method, path, &action)
        @method = method.to_s.downcase.strip.to_sym
        @path = Path.new path
        @action = action
    end

end

# Clase que representa un path de la forma
# /static1/static2/.../staticn/:opt1/:opt2.../file.ext
# Tiene la capacidad de hacer math con un path concreto
# y devolver los parametros.
class Path
    attr_accessor :extension, :parts
    def initialize(path)
        # Get the resource extension
        if(path.split('.').size == 1)
            @extension = nil
        else
            @extension = "." + path.split('.').last
        end
        path = path.sub(/#{@extension}$/,'') if @extension != nil
        @parts = path.split('/').reject{|a|a==""}
    end

    # Hace el match entre este path y otro dado, y retorna los valores
    # correspondientes a los parametros opcionales.
    def match? path        
        if(path.extension == @extension && static_match?(path) && values_match?(path))
            values = []
            @parts.each_with_index do |p,i|
                values << path.parts[i] if p[0] == ?:
            end
            values << path.extension[1..-1] if @extension != nil && @extension[1] == ?:
            return true,values
        else
            return false, nil
        end
    end 

    def static_match? path
        @parts.each_with_index do |p,i|
            puts p[0]
            return false unless p[0] == ?: || path.parts[i] == p
        end
        return true
    end

    def values_match? path
        return @parts.size == path.parts.size
    end
end
