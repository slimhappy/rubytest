# RubyTest
![alt tag](https://github.com/slimhappy/rubytest/raw/master/images/666.jpg)  

| Current Status|     Stats     |
| :------------: | :----------: |
| Total Files | 1 |

## update a crawler for bilibili rank_hot list
```ruby
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
```

results:

```ruby
JusticedeMacBook-Pro:crawler justice$ ruby bilibili_rank_hot.rb
连载动画 - 哔哩哔哩 (゜-゜)つロ 干杯~-bilibili
1【1月】OVERLORD 第二季 04【独家正版】综合评分：280.4万
2【1月】龙王的工作！ 04【独家正版】综合评分：129.7万
3【1月】卫宫家今天的饭 02【独家正版】综合评分：100.3万
1【1月】OVERLORD 第二季 04【独家正版】综合评分：280.4万
2【1月】龙王的工作！ 04【独家正版】综合评分：129.7万
3【1月】卫宫家今天的饭 02【独家正版】综合评分：100.3万
4【1月】紫罗兰永恒花园 04【独家正版】综合评分：75.5万
5【1月】刻刻 04【独家正版】综合评分：59.4万
6【1月】小木乃伊到我家 04【独家正版】综合评分：58.4万
7【1月】Fate/EXTRA Last Encore 02【独家正版】综合评分：43.3万
8【1月】博多豚骨拉面团 04【独家正版】综合评分：42.0万
9【1月】pop子和pipi美的日常 05【独家正版】综合评分：41.9万
10【1月】爱吃拉面的小泉同学 05综合评分：39.1万
```
## About slimhappy
* 2016 Graduated from University of Shanghai for Scince and Techology
* Always try to do something awesome (But often give up in the half way)

## Contact me
* Mail: 767059112@qq.com
* QQ: 1874510878
