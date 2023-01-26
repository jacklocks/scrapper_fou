require 'nokogiri'
require 'open-uri'

page = Nokogiri::HTML(URI.open("https://coinmarketcap.com/all/views/all/"))

  #On récupère le nom des devises.
def crypto_name(page)
  name_array = []
  page.xpath("//tr//td[3]//div").map { |name| name_array << name.text}
  return name_array
end

# On récupère la valeur des devises.
def crypto_value(page)
  value_array = []
  page.xpath("//tr//td//div//a/*").map { |value| value_array << value.text}
  return value_array
end

# On assemble les deux tableaux et on convertit en Hash.
crypto_hash = crypto_name(page).zip(crypto_value(page)).map{ |x| [x].to_h}
puts crypto_hash