use Rack::Reloader, 0
use Rack::ContentLength
use Rack::Static, :urls => ["/public"]


require './ruteo'
app = RuteoApp.new

run app