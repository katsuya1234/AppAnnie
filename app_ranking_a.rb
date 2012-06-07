require 'nokogiri'
require 'open-uri'
require 'mysql'
require 'time'
require 'mechanize'


## define data scope
@countries = ['united-states','japan']
@os = 'android'
@categories = ['overall','game','game/arcade','game/brain','game/cards','game/casual','game/racing','game/game-wallpaper','game/game-widgets','game/sports-games']
@a = Time.now()

## login 
agent = Mechanize.new()
agent.user_agent_alias = 'Mac Safari'
login_form = agent.get "https://www.appannie.com/account/login/"
form = login_form.forms
form[1].field_with(:name => "username").value = "hoge"
form[1].field_with(:name => "password").value = "hoge"
form[1].checkbox
result = form[1].submit
agent.cookie_jar

## Scrape
db = Mysql::new("hoge","hoge","hoge","hoge")
stmt = db.prepare "                                                                                                                                                                                               Insert into aan_10_ranking(an_ap_country,an_ap_category,an_ap_os,an_ap_rk,an_ap_score,an_ap_rk_dt,an_ap_rk_category,an_ap_permalink,an_ap_name,an_ap_url,an_timestamp) values(?,?,?,?,?,?,?,?,?,?,?)              "

90.times { |i|  @e = @a - 3600*24*(i+17)
  @date =  @e.year.to_s + '-' + @e.month.to_s + '-'  + (@e.day - 1).to_s
  puts @date
  
  @countries.each do |country|                                              
    puts @country = country
    
    @categories.each do |category|   
      puts @category = category
      
      @time = Time.now()
            
    doc = Nokogiri::HTML(open("http://www.appannie.com/top/android/#@country/#@category/?date=#@date"))
      
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
          stmt.execute @country,@category,@os,k,(301-k)*(301-k)/2,@date,'free',row['href'],row.content.strip,aa,@time.to_s
          k += 1
      end
        i = 1
        doc.css('td.top_gros a').each do |row|
        aa =  'http://www.appannie.com'  +  row['href']
        stmt.execute @country,@category,@os,i,(301-i)*(301-i)/2,@date,'gross',row['href'],row.content.strip,aa,@time.to_s
          i += 1
        end
        sleep 5
        
      rescue
      end  

      
      
    end
    
  end
  
}
