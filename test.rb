require 'rubygems'
require 'Nokogiri'
require 'selenium-webdriver'

Encoding.default_external = Encoding.find('utf-8')
class Bilibili_Ranklist_Tag

  @@count = 0   #count flag for Tag class

  def initialize(b_string)

    @@count += 1 
    @no = @@count #No of Tags

    if /(\d?\d月)/ =~ b_string
    
      @month = $1
      @subtag = false

    else
      if /(【.+?】)/ =~ b_string
      
        @month = false
        @subtag = $1

      end
    end

    @title_s = (b_string =~ /】/)
    @title_e = (b_string =~ /\s/)
    @title = b_string[@title_s+1,@title_e-@title_s-1]
    if /(\s\d\d)/ =~ b_string
    
      @episode = $1

    else

      @episode = false

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
    puts "月份：#{@month}" if @month
    puts "标签: #{@subtag}" if @subtag
    puts "标题：#{@title}"
    puts "集数：#{@episode}" if @episode
    puts "链接：#{@link}"
    puts "<bilibili独家哟！>" if @bilibilionly_flag
    puts "--------------------"
  end
  def isnew?(other)
    if self.episode.to_i > other.episode.to_i
      puts "本番剧有更新！"
    end
  end
  attr_accessor:no
  attr_accessor:month
  attr_accessor:subtag
  attr_accessor:title
  attr_accessor:episode
  attr_accessor:link
end


begin
  # #run a web-driver and goto target page
  # dr = Selenium::WebDriver.for :ie
  # url = 'https://www.bilibili.com/v/anime/serial/?spm_id_from=333.334.primary_menu.8#/'
  # dr.get url
  # #parse page with nokogiri
  # page = Nokogiri::HTML(dr.page_source)
  # topanimation_title = page.xpath('//p[@class="ri-title"]')
  # topanimation_link = page.xpath('//a[@class="ri-info-wrap clearfix"]/@href')
  # #print results
  # now_Array = []
  # for j in 0..(topanimation_title.size()-1)
  #   now_Array[j]=Bilibili_Ranklist_Tag.new(topanimation_title[j].text.to_s+" www.bilibili.com"+topanimation_link[j].to_s)
  # end
  now_Array = []
  i = 0
  File.open("./test.txt", "r+") do |io|
  while line = io.gets
    now_Array[i]=Bilibili_Ranklist_Tag.new(line.chomp)
    i = i+1
  end
  end

  now_Array.each do |a|
  	a.listinfo
  end

  puts "新建类总数#{Bilibili_Ranklist_Tag.count}"

  test_string = "【1月】OVERLORD 第二季 10【独家正版】 www.bilibili.com/video/av19822555/"
  test_tag = Bilibili_Ranklist_Tag.new(test_string.chomp)


rescue => errorinfo
  puts "诶哟出错咧！：)"
  puts errorinfo
end