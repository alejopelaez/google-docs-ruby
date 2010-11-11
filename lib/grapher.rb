
module Grapher
    #Default colors
    RED = "FF0000"
    GREEN = "00FF00"
    BLUE =  "0000FF"

    # Votos es un hash de la forma :candidato => [[valores],color]
    def Grapher.bar_chart nombre="Resultados", votos={}, width=400, height=200
        GoogleChart::BarChart.new("#{width}x#{height}", nombre, :vertical, false) do |bc|
            votos.each_pair {|k,v| bc.data(k.to_s, v[0],v[1])}
            bc.width_spacing_options({:bar_width => 60})
            return bc.to_url
        end
    end

    # Votos es un hash de la forma :candidato => valor
    def Grapher.pie_chart nombre="Resultados", votos={}, width=400, height=200
        GoogleChart::PieChart.new("#{width}x#{height}", nombre,true) do |pc|
            votos.each_pair {|k,v| pc.data(k.to_s, v)}
            return pc.to_url
        end
    end

end
