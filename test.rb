#get hot rank list from bilibili.com 
#using safari development mod
#using begin...
# 	   rescue...
#      end
require 'rubygems'
# require 'open-uri'
require 'Nokogiri'
# require 'watir'
require 'selenium-webdriver'
# page = Nokogiri::HTML(open("https://www.bilibili.com/v/anime/serial/?spm_id_from=333.334.primary_menu.8#/"))
# puts page.class
# link = page.css('div.r-con')
# puts link.css('li')
# link.each do |i|
# 	p link[i]["href"]
# end
dr = Selenium::WebDriver.for :ie
url = 'https://www.bilibili.com/v/anime/serial/?spm_id_from=333.334.primary_menu.8#/'

dr.get url
page = Nokogiri::HTML(dr.page_source)
link = page.xpath("//ul//li//a")
puts link
puts link[0]
puts link[0].to_s.rindex('href=')
# link.each do |i|
# 	puts i.to_s.rindex('href=')
# end