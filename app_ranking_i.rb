require 'nokogiri'
require 'open-uri'
require 'mysql'
require 'time'


# doc = Nokogiri::HTML(open('http://www.appannie.com/top/iphone/united-states/overall/'))

@b = Array.new()

@countries = ['united-states','japan','korea','china','united-kingdom']
@os = 'iphone'

# @country = 'japan'
# @category = 'games'
@categories = ['overall','books','business','education','entertainment','finance','games','healthcare-and-fitness','lifestyle','medical','music','navigation','news','photogaraphy','photography','reference','travel','weather']

@e = Time.now()
@date =  @e.year.to_s + '-' + @e.month.to_s + '-'  + (@e.day - 1).to_s

puts @date
puts @date.class



@countries.each do |country|                                             
  begin
  puts @country = country
  @categories.each do |category|
    puts @category = category 
    
    @a = Array.new()
    @b = Array.new()
    
    open("http://www.appannie.com/top/#@os/#@country/#@category/?date=#@date").each do |f|
      begin   
        @b << f.scan(/<td class="rank"(.*?)\/a><\/td><\/tr>/)
        @a = @b.uniq
      rescue
      end  
    end
    
    db = Mysql::new("localhost","root","","AANapp_test")
    stmt = db.prepare " Insert into aan_1_ranking(an_ap_country,an_ap_category,an_ap_os,an_ap_rk,an_ap_score,an_ap_rk_dt,an_ap_rk_category,an_ap_permalink,an_ap_name,an_ap_url,an_timestamp) values(?,?,?,?,?,?,?,?,?,?,?)"
    
    #### @paid, @free, @gros の切り出し
    @paid =Array.new()
    @free =Array.new()
    @gros = Array.new()
    
    @a.each do |line|
      begin
        line.to_s =~ /top_free(.*?)\/a><\/td>/
        @paid << $`
        @free << $~
        @gros << $'
      rescue
      end
    end
    
    #### rk,permalink,name のローデータ切り出し
    @ap_pl_row = Array.new()
    @rk_row = Array.new()
    @ap_name_row = Array.new()
  
    @paid.each do |line|
      begin
      line.to_s =~ /<a href=(.*?)>/
        @rk_row <<  $`[4,5]
        @ap_pl_row << $~
        @ap_name_row << $'
      rescue
      end
    end
    
    ## Dataのクレンジング
    @ap_pl = Array.new()
    @rk = Array.new()
    @ap_name = Array.new()
    @ap_url = Array.new()
    
    @ap_pl_row.each do |line|
      line.to_s =~  /app\/(.*?)\// 
      @ap_pl << $~   
      @ap_url << 'www.appannie.com/' + $~.to_s
    end 
    
    @ap_name_row.each do |line|
      line.to_s =~  /<\/a>(.*?)/
    @ap_name << $`
    end
    
    ## Mysqlに流し込み                                                                                                                                                                                        
    @d = Time.now()
    i = String.new()
    i = 0
    @ap_pl.each do |test|
      begin
      i += 1
        test2 = 'www.appannie.com/' + test.to_s 
        stmt.execute @country,@category,@os,i,301-i,@date,'paid',test.to_s,'',test2,@d.to_s
        puts test
      rescue
    end
    end
    
    #### free
    @ap_pl_row = Array.new()
    @rk_row = Array.new()
    @ap_name_row = Array.new()
    
    
    @free.each do |line|
    begin
      line.to_s =~ /<a href=(.*?)>/
      @rk_row <<  $`[4,5]
      @ap_pl_row << $~
      @ap_name_row << $'
    rescue
    end
  end

## Dataのクレンジング                                                                                                                                                                                     
    @ap_pl = Array.new()
    @rk = Array.new()
    @ap_name = Array.new()
    @ap_url = Array.new()
  
    @ap_pl_row.each do |line|
      line.to_s =~  /app\/(.*?)\//
      @ap_pl << $~
      @ap_url << 'www.appannie.com/' + $~.to_s
    end
    
    @ap_name_row.each do |line|
      line.to_s =~  /<\/a>(.*?)/
      @ap_name << $`
    end
    
    @d = Time.now()
    j = String.new()
    j = 0
    @ap_pl.each do |test|
    begin
      j += 1
      test2 = 'www.appannie.com/' + test.to_s
      stmt.execute @country,@category,@os,j,301-j,@date,'free',test.to_s,'',test2,@d.to_s
      puts test
    rescue
    end
  end
    
    
    
####  gross 
    @ap_pl_row = Array.new()
    @rk_row = Array.new()
    @ap_name_row = Array.new()
    
    @gros.each do |line|
      begin
      line.to_s =~ /<a href=(.*?)>/
        @rk_row <<  $`[4,5]
        @ap_pl_row << $~
        @ap_name_row << $'
      rescue
      end
    end
    
    ## Dataのクレンジング                                                                                                                                                                                     
    @ap_pl = Array.new()
    @rk = Array.new()
    @ap_name = Array.new()
    @ap_url = Array.new()
  
    @ap_pl_row.each do |line|
      line.to_s =~  /app\/(.*?)\//
      @ap_pl << $~
      @ap_url << 'www.appannie.com/' + $~.to_s
    end
    
    @ap_name_row.each do |line|
      line.to_s =~  /<\/a>(.*?)/
      @ap_name << $`
  end
    

    @d == Time.now()
    k = String.new()
    k = 0
    @ap_pl.each do |test|
      begin
        k += 1
        test2 = 'www.appannie.com/' + test.to_s
        stmt.execute @country,@category,@os,k,301-k,@date,'gross',test.to_s,'',test2,@d.to_s
        puts test
      rescue
      end
  end
    
  end
    
  rescue
  end
  
end
  
