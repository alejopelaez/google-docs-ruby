use Rack::Reloader, 0
use Rack::ContentLength

require './ruteo'
app = RuteoApp.new

run app