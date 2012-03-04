require 'nokogiri'
require 'open-uri'
require 'mysql'
require 'time'

db = Mysql::new("localhost","root","","AANapp_test")
stmt = db.prepare " Insert into aan_1_ap_info(an_ap_category2,an_ap_name2,an_dv_name,an_ap_price,an_ap_iap,an_ap_url2,an_timestamp) values(?,?,?,?,?,?,?)"

@urls = db.query "select an_ap_category,an_ap_url,an_ap_permalink from aan_1_ranking where an_ap_rk_category = 'gross' and an_ap_country ='united-states' 
 " 

@urls.each do |test|

@a = Array.new()
@d = Time.new()
@c = Array.new()


# www.appannie.com/

    @urls2 = db.query "select an_ap_url2 from aan_1_ap_info"
    i = String.new()
    i = 0
    @urls2.each do |url|

      @x = "www.appannie.com/" + test[2] 
    
      if  url[0] == @x
        i =+ 1
      end

    end
     

  begin
    
    if i == 0 then

      print 'http_request:'
      sleep 5
    
      doc = Nokogiri::HTML(open('http://' + @x))
      puts 'url_get'
      
      doc.css("h2").each do |h2|  
        @an_ap_name = h2.text   # title 
      end
      
      doc.css("h3").each do |h3|
        @a << h3.text
      end
      @a[0] =~ /by/
      @an_dv_name = $'.strip
      $`.strip =~ / /
      
      @an_ap_price = $`
      
      @an_ap_iap = @a[2]
      
      stmt.execute  test[0],@an_ap_name,@an_dv_name,@an_ap_price,@an_ap_iap,@x,@d.to_s
      
      puts @an_dv_name
      
    else
      puts 'exist'
    end
    
  rescue
    puts 'error'
  end
  
  
end


