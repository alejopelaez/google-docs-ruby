
class CountriesController
  def self.show(id)
    Country.getCountry(id)
  end
end
