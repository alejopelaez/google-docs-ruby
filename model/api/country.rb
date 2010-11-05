require 'httparty'
require 'crack'

module API
  class Country
    include HTTParty
    base_uri "http://spreadsheets.google.com/" #URL_CONFIG["api_url"]
    default_params :pub => "1",  :tqx => "responseHandler:callback"

    def self.get(*args)
      Crack::JSON.parse((super(*args)).parsed_response[9..-3])
    end

    def self.getCountry(key)
      get("/tq", :query => { :key => "#{key}"})
    end
  end
end

