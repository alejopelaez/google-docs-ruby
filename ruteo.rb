require './boot/gemas.rb'
require './boot/libs.rb'
require './boot/models.rb'
require './boot/controls.rb'


class RuteoApp
  include DSL
  include Template
  @@params = []
  get '/graphs/:where/:piedad/:jojoy/:reyes' do |w , p, j, r|
    @bar_chart = Grapher.bar_chart("Resultados en #{w}",{:Piedad => [[p.to_i],Grapher::RED], 
                                     :Jojoy => [[j.to_i],Grapher::BLUE],
                                     :Reyes => [[r.to_i],Grapher::GREEN]})
    "graphs/show"
  end
  post '/country' do 
    @country = CountriesController.show(@@params["key"])    
    @totales = @country.get_totals
    
    "countries/result2"
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
      begin
        return [200, {'Content-Type' => 'text/html'}, self.class.htmlize(self.class.erb(route.action.call(*vals)))]
      rescue Exception => e
        return [500, {'Content-Type' => 'text/html'}, "500 internall server error,#{e}"]
      end
    end
  end

end
