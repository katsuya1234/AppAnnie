require 'mechanize'
require 'open-uri'
require 'logger'
require 'kconv'


agent = Mechanize.new
agent.log = Logger.new 'mechlog'
agent.user_agent_alias = 'Mac Safari'
login_form = agent.get "https://www.appannie.com/account/login/"


## Login to AppAnnie                                                                                             
form = login_form.forms
form[1].field_with(:name => "username").value = "hogehoge"
form[1].field_with(:name => "password").value = "hogehoge"
form[1].checkbox
result = form[1].submit

result.each do |test|
  puts test
end

## Start to Scraping                                                                                             
open("http://www.appannie.com/top/iphone/united-states/games/?date=2012-02-08").each do |f|
  begin
    @b << f.scan(/<td class="rank"(.*?)\/a><\/td><\/tr>/)
    puts @a = @b.uniq
  rescue
  end
end
