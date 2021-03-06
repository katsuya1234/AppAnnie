require 'nokogiri'
require 'open-uri'
require 'mysql'
require 'time'

db = Mysql::new("localhost","root","","AANapp_test")

stmt = db.prepare " Insert into aan_2_dv_scoring(an_dv_name,an_dv_rk_category,an_dv_rk_dt,an_dv_score,an_timestamp) values(?,?,?,?,?)"


@drop = db.query "
drop table aan_2_dv_scoring
"


@create = db.query "

CREATE TABLE `aan_2_dv_scoring` (
  `an_id` int(11) NOT NULL AUTO_INCREMENT,
  `an_dv_name` varchar(48) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `an_dv_rk_category` varchar(48) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `an_dv_score` decimal(48,0) NOT NULL,
  `an_dv_rk_dt` varchar(48) COLLATE utf8_unicode_ci NOT NULL,
  `an_timestamp` timestamp NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`an_dv_name`,`an_dv_rk_category`),
  KEY `an_id` (`an_id`)
) ENGINE=InnoDB AUTO_INCREMENT=442 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
"

@urls = db.query "select an_dv_name,an_ap_rk_category,an_ap_rk_dt,sum(an_ap_score) from aan_1_ranking master 
join aan_1_ap_info info on info.`an_ap_url2`= master.`an_ap_url`
where an_ap_rk_category like '%'
group by an_dv_name,an_ap_rk_category
order by sum(an_ap_score) desc"

@urls.each do |test|

@a = Array.new()
@d = Time.new()

  begin

    puts @permalink = test[0]
    puts @category = test[1]
    puts @date = test[2]
    puts @score = test[3]    
    puts @d.to_s
 
    stmt.execute  @permalink,@category,@date,@score,@d.to_s

    rescue

    puts 'error'

  end
  
  
end


