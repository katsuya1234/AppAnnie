require 'nokogiri'
require 'open-uri'
require 'mysql'
require 'time'
require 'mechanize'

@countries = ['united-states','japan']
@os = 'iphone'

@categories = ['overall','game','game/arcade','game/brain','game/cards','game/casual','game/racing','game/game-wallpaper','game/game-widgets','game/sports-games']

# @categories = ['overall','game','application','finance','shopping','tools','business','comics','education','lifestyle','app-wallpaper','app-widgets','health-and-fitness','entertainment','media-and-video','news-and-magazines','photography','personalization','communication','sports','transportation','books-and-reference','music-and-audio','productivity','social','medical','travel-and-local','weather','libraries-and-demo']

@a = Time.now()

agent = Mechanize.new()
db = Mysql::new("localhost","root","","AANapp_test")
stmt = db.prepare "                                                                                                                                                                                               Insert into aan_10_ranking(an_ap_country,an_ap_category,an_ap_os,an_ap_rk,an_ap_score,an_ap_rk_dt,an_ap_rk_category,an_ap_permalink,an_ap_name,an_ap_url,an_timestamp) values(?,?,?,?,?,?,?,?,?,?,?)              "

90.times { |i|  @e = @a - 3600*24*i
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
