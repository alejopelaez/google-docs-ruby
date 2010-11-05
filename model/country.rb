class Country
  def self.getCountry(key)
    return API::Country.getCountry(key)
  end
end
puts Country.getCountry("0AsTunpthKrMxdEp5R1loYjBBcVhNQWVEc1BUZmZ1QUE")
