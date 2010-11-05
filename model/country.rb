require 'api/country'
class Country
  def self.getCountry(key)
    return API::Country.getCountry(key)
  end
end

