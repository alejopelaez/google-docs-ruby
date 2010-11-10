require 'api/gdocs'
class Table
  attr_accessor :id, :name, :votos
  def initialize(id, name, votos)
    @id = id
    @name = name
    @votos = votos
  end
  def to_s
    "#{@name}\n\t\t\t\t\t#{@votos}"
  end
  def self.getTable(key)
    parse_instance(API::Gdocs.getSheet(key),key)
  end
  protected
  def self.parse_instance(attributes, id)
    begin
      table = attributes["table"]
      name =  "mesa" + table["rows"][0]["c"][1]["v"].to_s
      
      rows = table["rows"]
      votos_content = {}
      blanks = false
      rows.each do |r|
        if r["c"][0]["v"].blank?
          blanks = true
        end
        if blanks and not r["c"][0]["v"].blank?
          votos_content[r["c"][0]["v"].downcase] = r["c"][1]["v"].to_i
        end
      end
      Table.new(id,name,votos_content)
    rescue
      raise Exception.new("Problems with the sheet #{id}")
    end
  end
  
end

