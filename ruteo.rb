require './lib/routes'
require './lib/dsl'
require './lib/template'
require './lib/grapher'
$LOAD_PATH << 'controller' 
require 'countries_controller'
$LOAD_PATH << 'model'
require 'country'
require 'state'
require 'city'
require 'center'
require 'table'

class RuteoApp
  include DSL
  include Template
  @@params = []
    
  post '/country' do 
    @country = CountriesController.show(@@params["key"])    
    @totales = @country.get_totals
    @bar_chart = Grapher.bar_chart("Resultados",{:Piedad => [[@totales[:piedad]],Grapher::RED], 
                                                  :Jojoy => [[@totales[:jojoy]],Grapher::BLUE],
                                                  :Reyes => [[@totales[:reyes]],Grapher::GREEN]})
    "countries/result"
  end
  
  get '/' do
    "index"
  end
  def call(env)
    path = env["PATH_INFO"]
    method = env['REQUEST_METHOD']
    @@params = Rack::Request.new(env).params
    route,vals = self.class.routes.match method, path
    if route.nil?
      return [404, {'Content-Type' => 'text/html'}, '404 page not found']
    else
      return [200, {'Content-Type' => 'text/html'}, self.class.htmlize(self.class.erb(route.action.call(*vals)))]
    end
  end

end
