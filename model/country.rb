require 'api/country'
class Country
  attr_accessor :id, :name, :states
  def initialize(id, name, states)
    @id = id
    @name = name
    @states = states
  end
  def to_s
    "#{@id} #{@name}"
  end
  def self.getCountry(key)
    parse_instance(API::Country.getCountry(key),key)
  end
  protected
  def self.parse_instance(attributes, id)
    code = attributes.response.code.to_i
    if code >= 200 and code < 300
      Country.new(id, attributes.parsed_response)
    else
      raise Exception.new("Problems with the sheet #{id}")
    end
  end
end

