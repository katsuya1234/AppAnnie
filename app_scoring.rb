require 'nokogiri'
require 'open-uri'
require 'mysql'
require 'time'

db = Mysql::new("localhost","root","","AANapp_test")



stmt = db.prepare " Insert into aan_2_ap_scoring(an_ap_name,an_ap_rk_category,an_ap_rk_dt,an_ap_score,an_ap_country,an_ap_category,an_timestamp) values(?,?,?,?,?,?,?)"


@drop = db.query "
drop table aan_2_ap_scoring
"

@create = db.query " 
CREATE TABLE `aan_2_ap_scoring` (
  `an_id` int(11) NOT NULL AUTO_INCREMENT,
  `an_ap_name` varchar(48) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `an_ap_rk_category` varchar(48) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `an_ap_score` decimal(48,0) NOT NULL,
  `an_ap_rk_dt` varchar(48) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `an_ap_country` varchar(48) COLLATE utf8_unicode_ci DEFAULT NULL,
  `an_ap_category` varchar(48) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `an_timestamp` timestamp NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`an_ap_name`,`an_ap_rk_category`,`an_ap_category`,`an_ap_rk_dt`),
  KEY `an_id` (`an_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3217 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
"


@urls = db.query "select an_ap_name2,an_ap_rk_category,an_ap_rk_dt,an_ap_score,an_ap_country,an_ap_category from aan_1_ranking master
join aan_1_ap_info s ON s.`an_ap_url2` = master.`an_ap_url`"

@urls.each do |test|

@a = Array.new()
@d = Time.new()

  begin

    puts test[0]
    puts test[1]
    puts test[2]
    puts test[3]
    puts test[4]
    
    stmt.execute  test[0],test[1],test[2],test[3],test[4],test[5],@d.to_s

    rescue

    puts 'error'

  end
  
  
end


