require 'api/gdocs'
class State
  attr_accessor :id, :name, :cities
  def initialize(id, name, cities)
    @id = id
    @name = name
    @cities = cities
  end
  def to_s
    "--#{@id} #{@name} #{@cities}--"
  end
  def self.getState(key)
    parse_instance(API::Gdocs.getSheet(key),key)
  end
  protected
  def self.parse_instance(attributes, id)
    begin
      table = attributes["table"]
      name = table["rows"][0]["c"][1]["v"]
      

      rows = table["rows"]
      cities_content = []
      blanks = false
      rows.each do |r|
        if r["c"][0]["v"].blank?
          blanks = true
        end
        if blanks and not r["c"][0]["v"].blank?
          cities_content << r["c"][1]["v"]
        end
      end
      cities = cities_content.map do |c|
         City.getCity(c)
      end

      State.new(id,name,cities)
    rescue
      raise Exception.new("Problems with the sheet #{id}")
    end
  end
  
end
