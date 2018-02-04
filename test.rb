#test file 
#using begin...
# 	   rescue...
#      end
require 'rubygems'
require 'nokogiri'
require 'open-uri'
page = Nokogiri::HTML(open("http://www.baidu.com/"))
puts page.class
