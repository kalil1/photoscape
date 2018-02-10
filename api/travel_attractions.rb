require 'httparty'
require 'nokogiri' #speaks HTML and XML

url = "http://www.10best.com/destinations/new-mexico/albuquerque/attractions/best-attractions-activities/"

response = HTTParty.get(url)
# p response.headers['Content-Type']

#String => Nokgiri::HTML => DocumentObjectModel (DOM)
dom = Nokogiri::HTML(response.body)
# p dom.css('html') #gives everything wthin the html tag


# destinations = dom.css('a.link-list__link') #break this up into all its individual pieces and then give size
#
# cities = []
# destinations.each do |city|
#   cities << city.text
# end
#
# links = []
# destinations.each do |link|
#   links << link['href']
# end
#
#   p cities
#   p links

attractions = dom.css('.list-headline h2').reverse

title = []
attractions.each do |place|
  title << place.text
end

images = dom.css('img.lazy').reverse

image = []
images.each do |picture|
  image << 'https:' + picture['data-src']
end

# p attractions
p title
p image
