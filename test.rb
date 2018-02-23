# File.open("./test.txt", "r+") do |io|
# 	while line = io.gets
# 		puts line.chomp
# 	end
# end

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
  end

  attr_accessor:month
  attr_accessor:title
  attr_accessor:episode
  attr_accessor:link
end

aa = []
i = 0
File.open("./test.txt", "r+") do |io|
	while line = io.gets
		aa[i]=Bilibili_Ranklist_Tag.new(line.chomp)
		i = i+1
	end
end
aa.each do |a|
	a.listinfo
end

puts Bilibili_Ranklist_Tag.count
# B_String2 = "【1月】魔卡少女樱 透明牌篇 05链接为www.bilibili.com/video/av19114197/"

# if /(【\d?\d月】)([\u4e00-\u9fa5|\s]*)(\d?\d)/ =~ b_string
#   month = $1
#   title = $2
#   episode = $3
# else
#   puts "字符串匹配失败：可能匹配失败字段为month/title/episode"
# end

# puts month
# puts title
# puts episode
# puts b_string[(b_string =~ /【\d?\d月】/)..(b_string =~ /】/)]

# puts b_string[(b_string =~ /】/)+1..(b_string =~ /\b\d\d\b/)-1]

# puts b_string =~ /【独家正版】/

# puts b_string[(b_string =~ /链接为/)..b_string.size]

