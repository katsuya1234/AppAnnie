
require 'nokogiri'
require 'open-uri'
require 'mysql'
require 'time'

@a = Array.new()
@b = Array.new()

db = Mysql::new("localhost","root","","AANapp_test")
stmt = db.prepare " 
Insert into aan_10_ranking(an_ap_country,an_ap_category,an_ap_os,an_ap_rk,an_ap_score,an_ap_rk_dt,an_ap_rk_category,an_ap_permalink,an_ap_name,an_ap_url,an_timestamp) values(?,?,?,?,?,?,?,?,?,?,?)
"

@country = 'united-state'
@category = 'game'
@os = 'android'
@date = '2012-03-03'
@time = Time.now()

doc = Nokogiri::HTML(open('http://www.appannie.com/top/android/united-states/game/?date=2012-03-03'))

begin
j = 1
doc.css('td.top_paid a').each do |row|
  aa =  'http://www.appannie.com'  +  row['href']
  stmt.execute @country,@category,@os,j,(301-j)*(301-j)/2,@date,'paid',row['href'],row.content.strip,aa,@time.to_s
  j += 1
end
k = 1
doc.css('td.top_free a').each do |row|
  aa =  'http://www.appannie.com'  +  row['href']
  stmt.execute @country,@category,@os,j,(301-k)*(301-k)/2,@date,'free',row['href'],row.content.strip,aa,@time.to_s
  k += 1
end
rescue
end






