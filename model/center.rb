require 'api/gdocs'
class Center
  attr_accessor :id, :name, :tables
  def initialize(id, name, tables)
    @id = id
    @name = name
    @tables = tables
  end
  def to_s
    "++#{@id} #{@name} #{@tables}++"
  end
  def self.getCenter(key)
    parse_instance(API::Gdocs.getSheet(key),key)
  end
  protected
  def self.parse_instance(attributes, id)
    begin
      table = attributes["table"]
      name = table["rows"][0]["c"][1]["v"]
      
      rows = table["rows"]
      tables_content = []
      blanks = false
      rows.each do |r|
        if r["c"][0]["v"].blank?
          blanks = true
        end
        if blanks and not r["c"][0]["v"].blank?
          tables_content << r["c"][1]["v"]
        end
      end
      tables = tables_content.map do |t|
        Table.getTable(t)
      end
      
      Center.new(id,name,tables)
    rescue
      raise Exception.new("Problems with the sheet #{id}")
    end
  end
  
end

