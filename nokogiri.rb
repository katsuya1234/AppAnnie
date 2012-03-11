require 'nokogiri'
require 'open-uri'
require 'mysql'
require 'time'

db = Mysql::new("localhost","root","","AANapp_test")
stmt = db.prepare " Insert into aan_1_ap_info(an_ap_category,an_ap_name,an_dv_name,an_ap_price,an_ap_iap,an_ap_url,an_timestamp) values(?,?,?,?,?,?,?)"

@urls = db.query "select an_ap_category,an_ap_url from aan_1_ranking where an_ap_rk_category = 'free'"


@urls.each do |test|

@a = Array.new()
@d = Time.new()

  begin
    
  doc = Nokogiri::HTML(open('http://' + test[1]))
    
    
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

    stmt.execute  test[0],@an_ap_name,@an_dv_name,@an_ap_price,@an_ap_iap,test[1],@d.to_s

    puts @an_dv_name

    sleep 5 

    rescue

    puts 'error'

  end
  
  
end


