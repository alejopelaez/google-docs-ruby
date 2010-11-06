
class CountriesController
  def show(id)
    Country.getCountry(id).to_s
  end
end
