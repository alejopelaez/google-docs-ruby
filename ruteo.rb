class RuteoApp    
    def test(env)
        [200, {"Content-Type" => "text/plain"}, "Funciona!!!"]
    end
    
    def test2(env)
        [200, {"Content-Type" => "text/plain"}, "Confirmado, funciona!!!"]
    end

    def call(env)
        path = env["PATH_INFO"][1..-1]
        case
        when path == ""
            [200, {"Content-Type" => "text/plain"}, "Pagina de inicio"]
        when (self.respond_to? path)
            self.send( path, env )
        else
            [200, {"Content-Type" => "text/plain"}, "Not found!!"]
        end
    end

end
