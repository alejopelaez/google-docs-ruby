require './lib/routes'
require './lib/dsl'
require './lib/template'
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
  get '/country/:id' do |id|
    c = CountriesController.new
    c.show(id)
    #  0AsTunpthKrMxdEp5R1loYjBBcVhNQWVEc1BUZmZ1QUE
  end
  
  post '/country' do 
    @country = CountriesController.show(@@params["key"])
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
