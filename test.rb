require 'nokogiri'
require 'open-uri'
require 'mysql'
require 'time'

@a = Array.new()
@b = Array.new()

db = Mysql::new("localhost","root","","AANapp_test")
stmt = db.prepare " Insert into aan_10_ranking(an_ap_country,an_ap_category,an_ap_os,an_ap_rk,an_ap_score,an_ap_rk_dt,an_ap_rk_category,an_ap_permalink,an_ap_name,an_ap_url,an_timestamp) values(?,?,?,?,?,?,?,?,?,?,?)"

@country = 'united-state'
@category = 'game'
@os = 'android'
@date = '2012-03-03'
@time = Time.now()


open("http://www.appannie.com/top/android/united-states/game/?date=2012-03-03").each do |f|
  
  @b << f.scan(/<a href="\/app\/android(.*?)\/">/)  
  
  @paid = Array.new()
  @free = Array.new()

end

  
  i = 1
  j = 1
  k = 1


  
@b.uniq.compact.each do |permalink|
  begin
      if permalink == nil
      elsif i.divmod(2)[1] == 1
        @url =  permalink[0]
        @url[0].class
        aa =  'http://www.appannie.com/app/android'  +  @url[0]
        stmt.execute @country,@category,@os,j,301-j,@date,'free',@url[0],'',aa,@time.to_s
        j += 1
        i += 1
      elsif  i.divmod(2)[1] == 0
        @url = permalink[0]
        @url[0].class
        aa =  'http://www.appannie.com/app/android'  +  @url[0]
        stmt.execute @country,@category,@os,k,301-k,@date,'paid',@url[0],'',aa,@time.to_s
        k += 1
        i += 1
      else
        puts 'error'
      end
  rescue
  end
  

end
  





