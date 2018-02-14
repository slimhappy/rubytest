str = "arufa beruta gagama deruta eisip"

pat = /(b[^ ]+ )(g[^ ]+ )(d[^ ]+ )/
refs = pat.match(str)
#匹配到beruta并返回索引值
puts refs.begin(1)
puts refs.end(1)
#匹配到gagama并返回索引值
puts refs.begin(2)
puts refs.end(2)
#匹配到deruta并返回索引值
puts refs.begin(3)
puts refs.end(3)
#匹配整个字符串中“b开头+g开头+d开头”的字符串并返回位置
puts refs.begin(0)
puts refs.end(0)

puts "offset:"
p rang0 = refs.offset(0)
p rang1 = refs.offset(1)
p rang2 = refs.offset(2)
p rang3 = refs.offset(3)

