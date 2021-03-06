class City
  attr_accessor :id, :name, :centers
  def initialize(id, name, centers)
    @id = id
    @name = name
    @centers = centers
  end
  def to_s
    "#{@name}\n\t\t\t#{@centers}"
  end
  def self.getCity(key)
    parse_instance(API::Gdocs.getSheet(key),key)
  end

  def get_totals
    if @totales.nil?
      @totales ||= {:piedad => 0, :reyes => 0, :jojoy => 0}
      @centers.each do |center|
        center.get_totals.each_pair do |c,v|
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
      centers_content = []
      blanks = false
      rows.each do |r|
        if r["c"][0]["v"].blank?
          blanks = true
        end
        if blanks and not r["c"][0]["v"].blank?
          centers_content << r["c"][1]["v"]
        end
      end
      centers = centers_content.map do |c|
         Center.getCenter(c)
      end
      
      City.new(id,name,centers)
    rescue Exception => e
      raise Exception.new("Problems with the sheet #{id}, #{e}")
    end
  end
  
end
