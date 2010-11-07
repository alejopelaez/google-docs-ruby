require 'api/country'
class Country
  attr_accessor :id, :name, :states
  def initialize(id, name, states)
    @id = id
    @name = name
    @states = states
  end
  def self.getCountry(key)
    parse_instance(API::Country.getCountry(key),key)
  end
  protected
  def self.parse_instance(attributes, id)
    
  end
end

