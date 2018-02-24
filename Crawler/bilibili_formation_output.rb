require 'rubygems'
require 'Nokogiri'
require 'selenium-webdriver'

Encoding.default_external = Encoding.find('utf-8')
class Bilibili_Ranklist_Tag
  @@count = 0   #count flag for Tag class
  def initialize(b_string)
    @@count += 1 
    @no = @@count #No of Tags
  if /(【\d?\d月】)([^\d]*)(\d?\d)/ =~ b_string
    @month = $1
    @title = $2
    @episode = $3
  # get month / title / episode information from a formated string
  else
    puts "字符串匹配失败：可能匹配失败字段为month/title/episode"
  end

  if /【独家正版】/ =~ b_string
    @bilibilionly_flag = true
  else
    @bilibilionly_flag = false
  end
  # judge if the tag is bilibilionly
  if /(www.+)/ =~ b_string
    @link = $1
  else
    puts "字符串匹配失败：可能匹配失败字段为link"
  end
  # get the link of tag
  end

  def Bilibili_Ranklist_Tag.count
    @@count
  end
  # def a classmethod for count
  def listinfo
    puts "排名：#{@no}"
    puts "月份：#{@month}"
    puts "标题：#{@title}"
    puts "集数：#{@episode}"
    puts "链接：#{@link}"
    if @bilibilionly_flag
      puts "bilibili独家：√"  
    else
      puts "bilibili独家：×"     
    end
    puts "--------------------"
  end

  attr_accessor:month
  attr_accessor:title
  attr_accessor:episode
  attr_accessor:link
end


begin
    #run a safari-driver and goto target page
  dr = Selenium::WebDriver.for :safari
  url = 'https://www.bilibili.com/v/anime/serial/?spm_id_from=333.334.primary_menu.8#/'
  dr.get url
  #parse page with nokogiri
  page = Nokogiri::HTML(dr.page_source)
  topanimation_title = page.xpath('//p[@class="ri-title"]')
  topanimation_link = page.xpath('//a[@class="ri-info-wrap clearfix"]/@href')
  #print results
  aa = []
  i = 0
  for i in 0..(topanimation_title.size()-1)
    aa[i]=Bilibili_Ranklist_Tag.new(topanimation_title[i].text.to_s+" www.bilibili.com"+topanimation_link[i].to_s)
    i = i+1
  end

  # File.open("./bilibili_test.txt", "r+") do |io|
  # while line = io.gets
  #   aa[i]=Bilibili_Ranklist_Tag.new(line.chomp)
  #   i = i+1
  # end
  # end
  aa.each do |a|
  a.listinfo
  end

  puts "新建类总数#{Bilibili_Ranklist_Tag.count}"
rescue => errorinfo
  puts "诶哟出错咧！：)"
  puts errorinfo
end