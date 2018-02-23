class Bilibili_Ranklist_Tag
  @@count = 0
  def initialize(b_string)
  	@@count += 1
  	@no = @@count
	if /(【\d?\d月】)([^\d]*)(\d?\d)/ =~ b_string
	  @month = $1
	  @title = $2
	  @episode = $3
	else
	  puts "字符串匹配失败：可能匹配失败字段为month/title/episode"
	end

	if /【独家正版】/ =~ b_string
	  @bilibili_flag = true
	else
	  @bilibili_flag = false
	end

	if /(www.+)/ =~ b_string
	  @link = $1
	else
	  puts "字符串匹配失败：可能匹配失败字段为link"
	end
  end

  def Bilibili_Ranklist_Tag.count
  	@@count
  end

  def listinfo
  	puts "排名：#{@no}"
  	puts "月份：#{@month}"
  	puts "标题：#{@title}"
  	puts "集数：#{@episode}"
  	puts "链接：#{@link}"
  	puts "--------------------"
  end

  attr_accessor:month
  attr_accessor:title
  attr_accessor:episode
  attr_accessor:link
end


begin
  aa = []
  i = 0
  File.open("./bilibili_test.txt", "r+") do |io|
	while line = io.gets
		aa[i]=Bilibili_Ranklist_Tag.new(line.chomp)
		i = i+1
	end
  end
  aa.each do |a|
	a.listinfo
  end

  puts "新建类总数#{Bilibili_Ranklist_Tag.count}"
rescue => errorinfo
	puts "诶哟出错咧！：)"
	puts errorinfo
end