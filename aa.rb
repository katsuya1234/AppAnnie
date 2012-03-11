require 'open-uri'
require 'mysql'
require 'time'

@b = Array.new()
@date = 'singapore'
@category = 'games'
@country = '2012-01-25'

open("http://www.appannie.com/top/iphone/#@date/#@category/?date=#@country").each do |f|
  begin
    @b << f.scan(/<td class="rank">(.*?)\/a><\/td><\/tr>/)
    @a = @b.uniq
  rescue
  end
end

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

@ap_pl = Array.new()
@rk = Array.new()
@ap_name = Array.new()

# [[">292</td><td class=\"top_paid app paid no_iap\"><span class=\"var change_down\">&#x25bc;118</span><a href=\"/app/slot-machine-fireball/\">Slot Machine - Fireball®</a></td><td class=\"       
# =\"
# href=\"/app/eclipsecraft/\">EclipseCraft</a></td><td class
# [[">300</td><td class=\"top_paid app paid no_iap\"><span class=\"var change_down\">&#x25bc;30</span><a 


@paid.each do |line|
  begin  
  line.to_s =~ /href=(.*?)>/

  puts $`  
  puts $~
  puts $'

  rescue
  end

end

