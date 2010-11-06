require 'routes'
require 'dsl'

$LOAD_PATH << 'controller' << 'model'
require 'countries_controller'
require 'country'
class RuteoApp
  include DSL

  get '/country/:id' do |id|
    c = CountriesController.new
    c.show(id)
    #  0AsTunpthKrMxdEp5R1loYjBBcVhNQWVEc1BUZmZ1QUE
  end

  def call(env)
    path = env["PATH_INFO"]
    method = env['REQUEST_METHOD']
    route,vals = self.class.routes.match method, path
    if route.nil?
      return [404, {'Content-Type' => 'text/html'}, '404 page not found']
    else
      return [200, {'Content-Type' => 'text/html'}, route.action.call(*vals)]
    end
  end

end
