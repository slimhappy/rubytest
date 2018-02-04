#get hot rank list from bilibili.com 
#using safari development mod
#using begin...
# 	   rescue...
#      end
require 'rubygems'
# require 'open-uri'
# require 'Nokogiri'
# require 'watir'
require 'selenium-webdriver'
# page = Nokogiri::HTML(open("https://www.bilibili.com/v/anime/serial/?spm_id_from=333.334.primary_menu.8#/"))
# puts page.class
# link = page.css('div.r-con')
# puts link.css('li')
# link.each do |i|
# 	p link[i]["href"]
# end
dr = Selenium::WebDriver.for :safari
url = 'https://www.bilibili.com/v/anime/serial/?spm_id_from=333.334.primary_menu.8#/'
dr.navigate.to url
dr.get url

puts dr.title

links_hot1_3 = dr.find_element(:class,'rank-list hot-list').find_elements(:class,'rank-item  show-detail first highlight')
links_hot1_3.each do |i|
	puts i.text
end
links_hot4_7 = dr.find_element(:class,'rank-list hot-list').find_elements(:class,'rank-item  show-detail')
links_hot4_7.each do |i|
	puts i.text
end
