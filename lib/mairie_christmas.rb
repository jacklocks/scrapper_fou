require 'rspec'
require 'open-uri'
require 'nokogiri'

townhall_url = Nokogiri::HTML(URI.open("https://www.annuaire-des-mairies.com/val-d-oise.html"))

def get_townhall_urls(townhall_url)
  url_arr = []
  townhall_url.css(".lientxt").map{|name| url_arr << name.text.downcase.gsub(" ","-")} 
  return url_arr
 end


def get_townhall_email(url_arr)

  townhall_email = []
  url_arr.each do |city|
    townhall = Nokogiri::HTML(URI.open("https://annuaire-des-mairies.com/95/#{city}.html"))
  townhall_email << townhall.xpath("/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]").text
  end
  return townhall_email
end
url_arr = get_townhall_urls(townhall_url)
townhall_email = get_townhall_email(url_arr)
city_array = url_arr.zip(townhall_email).map{|x| [x].to_h}
puts city_array




 