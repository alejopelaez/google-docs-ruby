require 'routes'
require 'dsl'
$LOAD_PATH << './model'
require 'country'
class RuteoApp
  include DSL

  get '/home' do
    "Hello World"
  end

  get '/home2' do
    "Yuhu"
  end

  get '/fecha/:month/:dia' do |month,dia|
    month.to_s + " " + dia.to_s
  end

  get '/country' do
    Country.getCountry("0AsTunpthKrMxdEp5R1loYjBBcVhNQWVEc1BUZmZ1QUE").to_s
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
