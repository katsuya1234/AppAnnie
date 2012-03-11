

require 'nokogiri'
require 'open-uri'
require 'mysql'
require 'time'


@rank = Array.new()
@paid = Array.new()
@paid = Array.new()



doc = Nokogiri::HTML(open('http://www.appannie.com/top/android/united-states/game/?date=2012-03-07'))
doc.css('table.top_apps tr').each do |row|
  puts row.content
end

