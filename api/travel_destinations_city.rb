require 'httparty'
require 'nokogiri' #speaks HTML and XML

url = "http://www.10best.com/destinations/all/"

response = HTTParty.get(url)
# p response.headers['Content-Type']

#String => Nokgiri::HTML => DocumentObjectModel (DOM)
dom = Nokogiri::HTML(response.body)
# p dom.css('html') #gives everything wthin the html tag

destinations = dom.css('a.rss')

cities = []
destinations.each do |city|
  cities << city.text
end

links = []
destinations.each do |link|
  links << 'http://www.10best.com' + link['href']
end

p cities
p links
