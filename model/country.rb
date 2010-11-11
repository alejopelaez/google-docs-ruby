require 'api/gdocs'
class Country
  attr_accessor :id, :name, :states
  def initialize(id, name, states)
    @id = id
    @name = name
    @states = states
  end
  def to_s
    "#{@name}\n\t#{@states}"
  end
  def self.getCountry(key)
    parse_instance(API::Gdocs.getSheet(key),key)
  end

  def get_totals
    if @totales.nil?
      @totales ||= {:piedad => 0, :reyes => 0, :jojoy => 0}
      @states.each do |s|
        s.get_totals.each_pair do |c, v|
          @totales[c] += v
        end
      end
    end
    @totales
  end

  protected
  def self.parse_instance(attributes, id)
    begin
      table = attributes["table"]
      name = table["rows"][0]["c"][1]["v"]
      rows = table["rows"]
      states_content = []
      blanks = false
      rows.each do |r|
        if r["c"][0]["v"].blank?
          blanks = true
        end
        if blanks and not r["c"][0]["v"].blank?
          states_content << r["c"][1]["v"]
        end
      end
      states = states_content.map do |s|
         State.getState(s)
      end
      Country.new(id, name, states)
    rescue
      raise Exception.new("Problems with the sheet #{id}")
    end
  end
end

