require 'nokogiri'
require 'open-uri'
require 'mysql'
require 'time'

db = Mysql::new("localhost","root","","AANapp_test")

stmt = db.prepare " Insert into aan_2_dv_scoring(an_dv_name,an_dv_rk_category,an_dv_rk_dt,an_dv_score,an_timestamp) values(?,?,?,?,?)"


@data = db.query "
select an_dv_name,an_dv_rk_dt,an_dv_score from aan_2_dv_scoring
where an_dv_rk_category like 'free'
order by an_dv_score desc
"

@data.each do |test|
  begin
    print test[0]
    print ': '
    print test[1]
    print ': '
    puts test[2]

  rescue
    
    puts 'error'
    
  end
  
  
end


