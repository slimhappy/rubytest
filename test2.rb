  if /(【.+?】)([\u4e00-\u9fa5].+?\s)(\d?\d)/ =~ "【剧场版/1080P】游戏人生ZERO【幻之字幕组】 www.bilibili.com/video/av19891611/"
  	puts $1
  	puts $2
  	puts $3
  else
  	puts "666"
  end
