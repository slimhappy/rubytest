str = "魔卡少女樱 透明牌篇"
if /([\u4e00-\u9fa5|\s]*)/ =~ str
  puts $1
else
  puts "666"
end