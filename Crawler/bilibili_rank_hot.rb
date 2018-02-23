#get hot rank list and it‘s url from bilibili.com 
#using safari development mod
#using begin...
# 	   rescue...
#      end
require 'rubygems'
require 'Nokogiri'
require 'selenium-webdriver'
#run a safari-driver and goto target page
dr = Selenium::WebDriver.for :safari
url = 'https://www.bilibili.com/v/anime/serial/?spm_id_from=333.334.primary_menu.8#/'
dr.get url
#parse page with nokogiri
page = Nokogiri::HTML(dr.page_source)
topanimation_title = page.xpath('//p[@class="ri-title"]')
topanimation_link = page.xpath('//a[@class="ri-info-wrap clearfix"]/@href')
#print results
for i in 0..(topanimation_title.size()-1)
  puts topanimation_title[i].text.to_s+" www.bilibili.com"+topanimation_link[i].to_s
end