# The Ruby Way

## learned what? 2018-02-07

### hash入门

```ruby
2.4.1 :022 > H=Hash["a"=>100,"b"=>300]
 => {"a"=>100, "b"=>300} 
2.4.1 :023 > H["a"]
 => 100 
2.4.1 :024 > H["b"]
 => 300 
```

### 华氏摄氏温度转换

```ruby
print "please enter a temperature and (C or F): "
str = gets
exit if str.nil? or str.empty?
str.chomp!
temp, scale = str.split(" ")

abort "#{temp} is not a valid number." if temp !~ /-?\d+/

temp = temp.to_f
case scale
	when "C","c"
		f = 1.8*temp + 32
	when "F","f"
		c = (5.0/9.0)*(temp-32)
else
	abort "Must specify C or F."
end

if f.nil?
	print "#{c} degrees C\n"
else
	print "#{f} degrees F\n"
end
```
#### Results:
```
JusticedeMacBook-Pro:rubytest justice$ ruby test.rb
please enter a temperature and (C or F): 98.6 F
37.0 degrees C
JusticedeMacBook-Pro:rubytest justice$ ruby test.rb
please enter a temperature and (C or F): 100 C
212.0 degrees F
JusticedeMacBook-Pro:rubytest justice$ ruby test.rb
please enter a temperature and (C or F): 92 G
Must specify C or F.
JusticedeMacBook-Pro:rubytest justice$ ruby test.rb
please enter a temperature and (C or F): junk F
junk is not a valid number.
```
#### Analysis:
1 使用print方法，调用自Kernel模块  
2 使用gets方法给str赋值，同样该方法调用自Kernel模块  
```
2.4.1 :012 > Kernel.private_instance_methods.grep(/^pr/)
 => [:printf, :print, :proc] 
2.4.1 :013 > Kernel.private_instance_methods.grep(/^ge/)
 => [:gem, :gets, :gem_original_require] 
```
3 明确一点：str不一定专指字符串，ruby中变量没有类型，不用声明变量。  
4 exit调用是终止程序的方法。if后为执行exit的判断条件。本句可改写为。  
```
exit if not str or str[0]
```

5 如果不输入直接回车：
```
2.4.1 :022 > str = gets

 => "\n" 
```
str仍然有值为"\n"，故考虑使用字符串进行判断前使用chomp方法
```
2.4.1 :023 > str
 => "\n" 
2.4.1 :024 > str.nil?
 => false 
2.4.1 :025 > str.empty?
 => false 
2.4.1 :002 > str.chomp! #这里的！表示str的值被改变了并无意义。
 => "" 
2.4.1 :003 > str.nil? #指向一个空字符串并非nil
 => false 
2.4.1 :004 > str.empty? #字符串无字符
 => true 

```
6 下一步需要对输入进行分词，并进行赋值，方法split使用空格作为分隔符，将字符串划分为数组。如果没有用chomp进行去掉"\n"会怎么样？
```
2.4.1 :013 > str = gets
666 666  
 => "666 666\n" 
2.4.1 :015 > str.split(" ")
 => ["666", "666"] 
 ```
 无事发生。。。仍旧可以以空格进行分词而且没有"\n"。  
 7 使用正则表达式判断输入的值是否为数字，如果不是则使用abort方法弹出程序，并提示语句。  
 8 当数据格式都没有问题后进行处理，对变量scale进行case操作。判断出相应的方法后，对temp进行数值处理。  
 9 输出结果。  

### 循环和分支

#### 条件语句

###### 1.if 形式：
```ruby
#type 1

if x < 5 then
	statement 1
end

#type 2

if x < 5 then
	statement 1
else
	statement 2
end

#type 3

statement if x==5

#type 4

x = if a>0 then b else c end
```

###### 2.unless 形式：
```ruby
#type 1

unless x >= 5 then
	statement 1
end

#type 2

unless x < 5 then
	statement 2
else
	statement 1
end

#type 3

statement unless x==5

#type 4

x = unless a<=0 then c else b end
```
###### 3.循环写法：(假设有一个list数组)
```ruby
#Loop 1(while)
#while循环的标准形式
i = 0
while i < list.size do
	print "#{list[i]}"
	i += 1
end

#Loop 2(until)
#until循环的标准形式
i = 0
until i == list.size do
	print "#{list[i]}"
	i += 1
end

#Loop 3(for)
#简明的for方式，遍历Array时的正确方法
#for循环是each调用时的简写！！
for x in list do
	print "#{list[i]}"
end

#Loop 4('each' iterator)
#使用each迭代器，遍历Array时的正确方法
list.each do |x|
	print "#{x}"
end

#Loop 5('loop'method)
#使用loop方法进行循坏，是Kernel模块下的一个通用方法
i = 0
n = list.size-1
loop do
	print "#{list[i]}"
	i += 1
	break if i > n
end

#Loop 6('loop'method)
i = 0
n = list.size-1
loop do
	print "#{list[i]}"
	i += 1
	break unless i <= n 
end

#Loop 7('times'iterator)
#利用Array有数值索引这一特点，times迭代器执行特定次数
n = list.size
n.times do |i|
	print "#{list[i]}"
end

#Loop 8('upto'iterator)
#利用Array有数值索引这一特点，upto迭代器执行其参数指定的次数
n = list.size
0.upto(n) do |i|
	print "#{list[i]}"
end

#Loop 9(for)
#使用范围操作索引值
n = list.size-1
for 
i in 0..n do
print "#{list[i]}"
end

#Loop 10('each_index')
#使用each_index迭代器遍历数组
list.each_index do |x|
	print "#{list[x]}"
end
```
##### 定义一个迭代器：
```ruby
def my_sequence
	for i in 1..10 do
		yield i       #yield表示代码块
	end
end

my_sequence{|x| puts x**3}	#此处将yield=> puts x**3
```

### 异常

#### raise方法
```ruby
raise
raise "some error"
raise ArgumentError
raise ArgumentError,"Bad data"
raise ArgumentError.new("Bad data")
raise ArgumentError,"Bad data",caller[0]
```

#### begin..end方法
根据Error进行尝试修复：  
```ruby
begin
	do some thing...
rescue ErrorName
	do some rescue...
end
```
捕获异常=>err   
```ruby
begin
	do some thing...
rescue => err    #rescue ErrorName => err 
	do some thing...
end	
```
rescue也救不了怎么办？  
```ruby
begin
	do some thing...
rescue Type1
	do some thing...
...
else
	do some thing if can't rescue...
end	
```
有东西一定要做该怎么办？  
```ruby
begin
	do some thing...
rescue Type1
	do some thing...
...
else
	do some thing if can't rescue...
ensure
	do some thing must be done...
end	
```
我写了一句code 马上想要rescue怎么办？
```ruby
x = a/b rescue puts（"Division by Zero!")
```
我想在方法里尝试修复错误怎么办？
```ruby
def some_method
	#code
rescue
	#recovery
end
```
## learned what? 2018-02-10

### ruby OOP

#### 创建对象的方式：  
1. 使用new 方法：  
```ruby
myFile = File.new("textfile.txt","w")
myString = String.new("This is a string object")
```
2. 有一些方法可以不用new：  
```ruby
yourString = "this is also a string object"
aNumeber = 5
```

#### 创建类
1. 结构：
```ruby
class ClassName
#...
end
```
2. 定义类举例：
例1:
```ruby
class Friend_zhangbi
	@@myname = "Friend_zhangbi" #defined a class variable

	def initialize(name,sex,phone)
		@name,@sex,@phone = name, sex, phone
		#defined some instance variables
	end

	def hello # an instance method
		puts "Hi,I'm #{@name}."
	end

	def Friend_zhangbi.our_common_friend # a class method
		puts "we are all friends of #{@@myname}."
	end

	def say_sex
		puts "I'm #{@sex}"
	end
end 

f1 = Friend_zhangbi.new("Sixbrother","F","666")
f2 = Friend_zhangbi.new("Weibroher","M","777")

f1.hello
f1.say_sex
f2.hello
f2.say_sex

puts Friend_zhangbi.our_common_friend
```
例2:
```ruby
class MyClass
	NAME = "Class Name" #set a class constant
	@@count = 0 # set & Initialize a class variable
	def initialize #
		@@count += 1
		@myvar = 10
	end

	def MyClass.getcount #class method
		@@count	#class variable
	end

	def getcount #instance returns class variable!
		@@count #class variable
	end

	def getmyvar #instance method
		@myvar #instance variable
	end

	def setmyvar(val) #instance method sets @myvar
		@myvar = val
	end
	def myvar(val) #another way to set @myvar
		@myvar = val
	end

end

foo = MyClass.new 
puts foo.getmyvar
foo.setmyvar(20)
puts foo.getmyvar
foo.myvar(30)
puts foo.getmyvar
```
其中：
```ruby
	def getmyvar #instance method
		@myvar #instance variable
	end

	def setmyvar(val) #instance method sets @myvar
		@myvar = val
	end
	def myvar(val) #another way to set @myvar
		@myvar = val
	end
```
可以用下述代码代替：
```ruby
	attr_accessor :myvar #accessor(存取器)
	# attr_reader :myvar
	# attr_writer :myvar
```

3. 修饰方法：private protect public.   

4. 类的继承：  
```ruby
class MyClass
	def hello
		puts "666"
	end
end

class YourClass < MyClass
	
end

foo = YourClass.new
foo.hello 
```
5. 类方法的别名：    
```ruby
class MyClass
	def hello
		puts "666"
	end
	
end

class YourClass < MyClass
	alias exhello hello
end


foo = YourClass.new
foo.exhello 
```

### 运行时拼接代码：
```ruby
def calculate(op1,operator,op2)
	string = op1.to_s + operator + op2.to_s
	eval(string)
end
@alpha = 25

puts calculate(2,"+",2)
puts calculate(5,"*","@alpha")
```

### 反射：  
概念：活动环境可以查询定义自己的对象，并在运行时扩展或修改他们。  
诸如defined? respond_to? is_a?这一类方法都是反射的表现

### 字符串

#### 多行字符串使用（here文档）
```ruby
str = <<EOF
高级工程师六哥,
高级程序员番薯,
机关要务员伟哥
EOF
puts str
```
假设需要末尾EOF缩进  
```ruby
str = <<-EOF
高级工程师六哥,
高级程序员番薯,
机关要务员伟哥
		EOF

puts str
```
每次处理每一个字符：  
```ruby
str = "ABC"
str.each_byte{|char| print char," "}
# Produces output: 65 66 67
```
```ruby
str = "ABC"
chars = str.scan(/./)
chars.each do |char|
	print char," "
end
# Produces output: A B C
# chars.class=>Array
```
特殊字符比较：  
```ruby
class String #重写了String类下的 <=>方法

	alias old_compare <=>

	def <=>(other)
		a = self.dup
		b = other.dup
		#remove punctutation
		a.gsub!(/[\,\.\?\!\:\;]/, "")
		b.gsub!(/[\,\.\?\!\:\;]/, "")
		#remove leading/trailing whitespace
		a.gsub!(/^(a |an |the )/i, "")
		b.gsub!(/^(a |an |the )/i, "")
		a.strip!
		b.strip!
		#Use the old <=>
		puts a.length
		puts b.length
		a.old_compare(b)
	end
end

title1 = "Calling All Cars"
title2 = "The Call of the world"

if title1 < title2
	puts "yes"
else
	puts "no"
end
```
分解字符串：  
slipt用法.   
```ruby
s1 = "It was a dark and stormy night"
words = s1.split

s2 = "apples,pears, and peaches"
list = s2.split(",")

s3 = "lions and tigers and bears"
zoo = s3.split(/ and /)

# split规则说明：
# 1. 如果忽略后面的参数，则忽略末尾的空值项
# 2. 如果后面有正参数，则返回的最大字段数由该字段决定
# 3. 如果后面的参数是负数，对返回的字段数没有限制，并保留末尾空项

str = "alpha,beta,gamma,,"
list1 = str.split(",")
list2 = str.split(",",2)
list3 = str.split(",",4)
list4 = str.split(",",8)
list5 = str.split(",",-1)
```
scan用法：  
```ruby
2.4.1 :012 > s1.scan("a")
 => ["a", "a"] 
2.4.1 :013 > s1.scan(/\w+/)
 => ["it", "is", "a", "dark", "dog"] 
 ```
StringScanner：  
```ruby
require 'strscan'
str = "watch how i soar!"
ss = StringScanner.new(str)
loop do 
	word = ss.scan(/\w+/)
	break if word.nil?
	puts word 
	sep = ss.scan(/\W+/)
	break if sep.nil?
end
```
格式化字符串：
```ruby
name = "Bob"
age = 28
str = sprintf("hi, %s... I see you're %d years old.", name, age)
puts str
```
ljust/center/rjust
```ruby
2.4.1 :001 > str = "Moby-Dick"
 => "Moby-Dick" 
2.4.1 :002 > s1 = str.ljust(13)
 => "Moby-Dick    " 
2.4.1 :003 > s1 = str.center(13)
 => "  Moby-Dick  " 
2.4.1 :005 > s1 = str.rjust(13)
 => "    Moby-Dick" 
2.4.1 :006 > s1 = str.ljust(13,"-")
 => "Moby-Dick----" 
2.4.1 :007 > s1 = str.center(13,"+")
 => "++Moby-Dick++" 
2.4.1 :008 > s1 = str.rjust(13,"123")
 => "1231Moby-Dick" 
```
#### 控制大小写：  
upcase/downcase/capitalize
```ruby
2.4.1 :009 > s1 = "sb is a way"
 => "sb is a way" 
2.4.1 :010 > s2 = s1.downcase
 => "sb is a way" 
2.4.1 :011 > s3 = s1.upcase
 => "SB IS A WAY" 
2.4.1 :012 > s4 = s1.capitalize
 => "Sb is a way" 
 ```
swapcase
```ruby
2.4.1 :013 > s1 = "SB is a way"
 => "SB is a way" 
2.4.1 :014 > s1.swapcase
 => "sb IS A WAY" 
 ```
casecmp(字符串比较,忽略大小写)
```ruby
2.4.1 :015 > n1 = "abc".casecmp("xyz")
 => -1 
2.4.1 :016 > n2 = "abc".casecmp("XYZ")
 => -1 
2.4.1 :017 > n3 = "ABC".casecmp("xyz")
 => -1 
2.4.1 :018 > n3 = "ABC".casecmp("abc")
 => 0 
2.4.1 :019 > n4 = "xyz".casecmp("abc")
 => 1 
```
检测大小写：  
```ruby
if string =~ /[a~z]/
	puts "string contains lowercase characters"
end

if string =~ /[A~Z]/
	puts "string contains lowercase characters"
end

if string =~ /[A~Z]/ and string =~ /[a~z]/
	puts "string contains mixed characters"
end

if string[0..0] =~ /[A~Z]/
	puts "string contains mixed characters"
end
```
获取和设置子字符串
```ruby
2.4.1 :020 > str = "six brother"
 => "six brother" 
2.4.1 :022 > sub1 = str[4,7]
 => "brother" 
2.4.1 :023 > sub1 = str[4,99]
 => "brother" 
2.4.1 :024 > sub1 = str[4,-4]
 => nil 
2.4.1 :026 > sub1 = str[-7,4]
 => "brot" 
2.4.1 :032 > sub1 = str[/b.*r/]
 => "brother" 
2.4.1 :033 > sub1 = str["broth"]
 => "broth" 
2.4.1 :034 > ch1 = str[0]
 => "s" 

```
字符串替换：
```ruby
2.4.1 :046 > str = "sb is a Way."
 => "sb is a Way." 
2.4.1 :047 > pos1 = str.sub(/sb/,"666")
 => "666 is a Way." 
2.4.1 :050 > s1 = "alfalfa abracadabra"
 => "alfalfa abracadabra" 
2.4.1 :051 > s2 = s1.gsub(/a[bl]/,"xx")
 => "xxfxxfa xxracadxxra" 
2.4.1 :054 > s3 = s1.gsub!(/[lfdbr]/){ |m| m.upcase + "-" }
 => "aL-F-aL-F-a aB-R-acaD-aB-R-a" 
```
to_s和to_str的区别
```ruby
class Helium
	def to_s
		"he"
	end
	def to_str
		"helium"
	end
end

e = Helium.new
print "Element is "
puts e
puts "Element is "+ e
puts "Element is #{e}"
```
=====>:
```
JusticedeMacBook-Pro:rubytest justice$ ruby test.rb
Element is he
Element is helium
Element is he
```
删除字符串中的空白(strip)
```ruby
C:\Users\Justice\Desktop>irb
irb(main):001:0> str1 = "\t \nabc \t\n"
=> "\t \nabc \t\n"
irb(main):002:0> str2 = str1.strip
=> "abc"
irb(main):003:0> str3 = str1.strip!
=> "abc"
irb(main):004:0> str1
=> "abc"
irb(main):005:0> str1 = "  abc  "
=> "  abc  "
irb(main):006:0> str1.lstrip
=> "abc  "
irb(main):007:0> str1.rstrip
=> "  abc"
irb(main):008:0> str1 = " \n abc  "
=> " \n abc  "
irb(main):009:0> str1.lstrip
=> "abc  "
irb(main):010:0> str1 = " \n\t abc  "
=> " \n\t abc  "
irb(main):011:0> str1.lstrip
=> "abc  "
```

重复字符串：
```ruby
irb(main):012:0> etc = "Etc."*3
=> "Etc.Etc.Etc."
```
字符串延迟插入：  
```ruby
str = proc {|x,y,z| "the numbers are #{x},#{y},#{z}"}
str1 = str.call(1,2,3)
str2 = str.call(4,5,6)
puts str1
puts str2
```
算出来的字符串：  
```ruby
str = '#{name} niubi #{hello}'
name = "666"
hello = "hello"
str1 = eval(' "'+str+'" ')
p str1
```
将逗号分隔的字符串编程数组：
```ruby
irb(main):001:0> string = gets.chop!
666,777,888,999
=> "666,777,888,999"
irb(main):002:0> data = eval("["+string+"]")
=> [666, 777, 888, 999]
irb(main):003:0> data.class
=> Array
```

#### rot13编码

```ruby
class String

  def rot13
  	self.tr("A-Ma-mN-Zn-z","N-Zn-zA-Ma-m")
  end

end

joke = "Y2K bug"
joke13 = joke.rot13
puts joke13

episode_2 = "Fcbvyre: Naanxva qbrfa'g trg xvyyq."
puts episode_2.rot13
```

#### 字符串加密

```ruby
coded = ("666").crypt("hf")

puts "Speak,friend,and enter!"

print "Password:"
password = gets.chop

if password.crypt("hf") == coded
  puts "Welcome!"
else
  puts "What are you,an orc?"
end
```

#### 字符串压缩

使用zlib库进行压缩：  
```ruby
require 'zlib'
include Zlib

long_string = ("abcde"*71 + "defghi"*79 +"ghijkl"*113)*371

s1 = Deflate.deflate(long_string,BEST_SPEED)
s2 = Deflate.deflate(long_string)
s3 = Deflate.deflate(long_string,BEST_COMPRESSION)

puts s1.size() #4188
puts s2.size() #3567
puts s3.size() #2120
```

#### 计算字符串中的字符数

count 方法:
```ruby
2.4.1 :002 > a = s1.count("c")
 => 1 
2.4.1 :003 > a = s1.count("bdr")
 => 5 
2.4.1 :004 > c = s1.count("^a")
 => 6 
2.4.1 :005 > c = s1.count("bdr")
 => 5 
2.4.1 :006 > e = s1.count("a-d")
 => 9 
2.4.1 :007 > e = s1.count("^a-d")
 => 2 
```

#### 字符串反转

reverse方法  
```ruby
2.4.1 :001 > s1 = "987654321"
 => "987654321" 
2.4.1 :002 > s2 = s1.reverse
 => "123456789" 
2.4.1 :003 > s1.reverse!
 => "123456789" 
```

#### 删除重复的字符

squeeze方法：

```ruby
2.4.1 :004 > s1 = "bookkeeper"
 => "bookkeeper" 
2.4.1 :005 > s2 = s1.squeeze
 => "bokeper" 
2.4.1 :006 > s3 = s1.squeeze("o")
 => "bokkeeper" 
```
反转句子中的单词：  
```ruby
phrase = "niubi de liuge"
puts phrase.split(" ").reverse.join(" ")
#liuge de niubi
```

#### 删除指定的字符
delete 方法
delete！方法
```ruby
2.4.1 :001 > s1 = "to be, or not to be"
 => "to be, or not to be" 
2.4.1 :002 > s2 = s1.delete("b")
 => "to e, or not to e" 
2.4.1 :003 > s3 = "Veni,vidi,vici!"
 => "Veni,vidi,vici!" 
2.4.1 :004 > s4 = s3.delete(",!")
 => "Venividivici" 
```

#### 打印特殊字符
dump方法
```ruby
2.4.1 :001 > s1 = "Listen" << 7 << 7 << 7
 => "Listen\a\a\a" 
2.4.1 :002 > puts s1.dump
"Listen\a\a\a"
```

#### 生成后续字符串
succ方法
```ruby
2.4.1 :003 > droid = "R2D2"
 => "R2D2" 
2.4.1 :004 > droid.succ
 => "R2D3" 
```
upto方法
```ruby
"Files,A".upto "Files,X" do |letter|
  puts "opening : #{letter}"
end
```
results:
```
opening : Files,A
持续打印...
opening : Files,X
```

#### 计算32位的CRC

循环冗余校验和：  
用于获得文件或其他字节集的“签名的方式。  
```ruby
require 'zlib'
include Zlib
puts crc = crc32("hello")			#907060870
puts crc = crc32(" world!",crc)		#62177901
puts crc = crc32("hello world!")	#62177901
```

#### 两个字符串之间的Levenshtein距离

```ruby
class String

  def levenstein(other, ins=2, del=2, sub=1)
  	#默认值设置
  	return nil if self.nil?
  	return nil if other.nil?
  	dm = []  #距离矩阵
  	#初始化第一行数据
  	dm[0] = (0..self.length).collect{ |i| i * ins}
  	fill = [0] * (self.length - 1)

  	for i in 1..other.length
  	  dm[i] = [i * del, fill.flatten]
  	end

  	#populate matrix
  	for i in 1..other.length
  	for j in 1..self.length
  	  dm[i][j] = [
  	  	dm[i-1][j-1] +
  	  	  (self[j-1] == other[i-1] ? 0 : sub),
  	  	    dm[i][j-1] + ins,
  	  	  dm[i-1][j] + del
  	  	].min
  	  end
    end
	dm[other.length][self.length]
  end
end

s1 = "abc"
s2 = "abd"

d1 = s1.levenstein(s2)

puts d1

```

### 正则表达式

#### 正则表达式语法：

/ruby/ 匹配单词ruby
```ruby
irb(main):001:0> try = /ruby/
=> /ruby/
irb(main):002:0> try =~ "ruby"
=> 0
irb(main):003:0> try =~ "Ruby"
=> nil
```

/[Rr]uby/ 匹配Ruby或ruby
```ruby
irb(main):004:0> try = /[Rr]uby/
=> /[Rr]uby/
irb(main):005:0> try =~ "Ruby"
=> 0
irb(main):006:0> try =~ "ruby"
=> 0
```

/^abc/ 匹配行首是abc
```ruby
irb(main):001:0> fx = /^abc/
=> /^abc/
irb(main):002:0> fx =~ "abcdef"
=> 0
irb(main):003:0> fx =~ "defabc"
=> nil
irb(main):004:0> fx =~ "defabc\nabcdef"
=> 7
```

/^def/ 匹配行尾是def
```ruby
irb(main):005:0> fx = %r(def$)
=> /def$/
irb(main):006:0> fx =~ "abcdef"
=> 3
irb(main):007:0> fx =~ "defabc"
=> nil
```
匹配地址
```ruby
irb(main):015:0> ssn = "dizhi9890-76-2838"
=> "dizhi9890-76-2838"
irb(main):016:0> pattern = /\d\d\d\d-\d\d-\d\d\d\d/
=> /\d\d\d\d-\d\d-\d\d\d\d/
irb(main):017:0> pattern =~ ssn
=> 5
irb(main):018:0> pattern = /\d{4}-\d{2}-\d{4}/
=> /\d{4}-\d{2}-\d{4}/
irb(main):019:0> pattern =~ ssn
=> 5
```

#### 正则表达式术语

1. 贪婪与非贪婪：  
贪婪：尽可能匹配长的字符串  
非贪婪：只匹配关键词  
例子：
贪婪：（添加 * 号）
```ruby
str = "Where the sea meets the moon-blanch'd land,"
match = /.*the/.match(str)
p match[0]
```
非贪婪：（添加？号）
```ruby
str = "Where the sea meets the moon-blanch'd land,"
match = /.*?the/.match(str)
p match[0]
```

#### 正负预检

```ruby
s1 = "New World Dicthionary"
s2 = "New World Symphony"
s3 = "New World Order"
puts "正预查示例"
reg = /New World(?= Dicthionary| Symphony)/
m1 = reg.match(s1)
puts m1.to_a[0]
m2 = reg.match(s2)
puts m2.to_a[0]
m3 = reg.match(s3)
puts m3.to_a[0]
puts "负预查示例"
reg2 = /New World(?! Symphony)/
m1 = reg2.match(s1)
puts m1.to_a[0]
m2 = reg2.match(s2)
puts m2.to_a[0]
m3 = reg2.match(s3)
puts m3.to_a[0]
```

#### 访问后向引用
解决了如何饮用匹配到的值。
```ruby
str = "a123b45c678"
if /(a\d+)(b\d+)(c\d+)/ =~ str
  puts "Matches are '#$1','#$2','#$3'"
end
```
要注意使用sub和gsub的时候不能用#$1这种变量  
如果要使用，则需要使用特殊编码\1    
```ruby
str = "a123b45c678"
str.sub!(/(a\d+)(b\d+)(c\d+)/, 'Matches are \1,\2,\3')
puts str
#=>Matches are a123,b45,c678
```
```
注意这个示例'Matches are \1,\2,\3'使用了单引号，如果使用双引号，将被解释为八进制转译序列：
```
```ruby
str = "a123b45c678"
str.sub!(/(a\d+)(b\d+)(c\d+)/, "Matches are \1,\2,\3")
p str  #八进制无法用puts表示出来，这里用p
#=>"Matches are \u0001,\u0002,\u0003"
```
那么我要用双引号该怎么办？当然是使用转译符号啦。  
```ruby
str = "a123b45c678"
str.sub!(/(a\d+)(b\d+)(c\d+)/, "Matches are \\1,\\2,\\3")
p str  #八进制无法用puts表示出来，这里用p
#=>"Matches are a123,b45,c678"
```
使用代码块形式替换:  
```ruby
str = "a123b45c678"
str.sub!(/(a\d+)(b\d+)(c\d+)/)  { "Matches are #$1,#$2,#$3"}
puts str  #跟上代码块为什么会执行不是很清楚。需要之后学习学习
#见使用字符类
#=>"Matches are a123,b45,c678"
```
使用类方法Regexp.last_match方法进行匹配并输出结果：  
```ruby
pat = /(.+[aiu])(.+[aiu])(.+[aiu])(.+[aiu])/
refs = pat.match("Fujiyama")
x = refs[1] #contains all string
y = refs[2..3] #contains all matched string
puts refs.class   #=>MatchData
refs.to_a.each do |x|
  print "#{x}\n"
end
#=>Fujiyama
#  Fu
#  ji
#  ya
#  ma
```
找出子匹配并返回对应位置：  
```ruby
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
```
接上，可以使用offset方法返回子匹配的位置:  
```ruby
puts "offset:"
p rang0 = refs.offset(0)
p rang1 = refs.offset(1)
p rang2 = refs.offset(2)
p rang3 = refs.offset(3)
# =>offset:
# [6, 27]
# [6, 13]
# [13, 20]
# [20, 27]
```
要获取匹配部分前面的字符串部分或者后面的部分可以使用pre_match和post_match方法。
```ruby
puts "pre_match & post_match:"
p refs.pre_match	#=>"arufa " (注意这里有个空格)
p refs.post_match	#=>"eisip"
```

### 使用字符类：
字符类是一种选择形式，其中每个子匹配是一个字符。  

1. 在方括号中列出一组字符：  
```
/[aeiou]/  # 等价于/(a|e|i|o|u)/匹配单个字符
/[.\n?]/   # 转译字符有效，但是诸如. ?这种字符就成为了普通字符不具有特殊含义
/[^aeiou]/ # ^打头表示取反，即匹配除了aeiou之外的字符
/[a-mA-M]/ # 表示匹配字符范围
```

一些正则表达式示例：  

1. 匹配IP地址（IPv4）：  
```ruby
num = "(\\d|[01]?\\d\\d|2[0-4]\\d|25[0-5])"
pat = "^(#{num}\.){3}#{num}$"
ip_pat = Regexp.new(pat)
ip1 = "255.168.1.11"

if ip1 =~ ip_pat
  puts "yes"
else
  puts "no"
end
```

2. 匹配罗马数字
```ruby
rom1 = /m{0,3}/i
rom2 = /(d?c{0,3}|c[dm])/i
rom3 = /(l?x{0,3}|x[lc])/i
rom4 = /(v?i{0,3}|i[vx])/i
roman = /^#{rom1}#{rom2}#{rom3}#{rom4}$/

year1985 = "MCMLXXXV"

if year1985 =~ roman
  puts "yes"
else
  puts "no"
end
```

3. 匹配日期/时间字符串
```ruby
mo = /(0?[1-9]|1[0-2])/       	#月份01~09或者10~12或者1~9
dd = /([0-2]?[1-9]|[1-3][01])/	#日期前半表示1～9或01～09或11～19或21～29，后半表示10 20 30 11 21 31
yy = /(\d\d)/					#没啥好说的年份就是两位数字
hh = /([01]?[1-9]|[12][0-4])/	#前半表示01～09或1～9或11～19，后半表示10～14或20～24
mi = /([0-5]\d)/
ss = /([0-6]\d)?/
date = /(#{mo}\/#{dd}\/#{yy})/
time = /(#{hh}:#{mi}:#{ss})/

datetime = /(#{date} #{time})/
str = "time is 02/17/18 16:51:40"

puts str.scan(datetime)
```

### 执行数值计算

#### ruby数值表示：
可以使用下划线分割大数字
```ruby
2.4.1 :001 > 102928
 => 102928 
2.4.1 :002 > 10_29_28
 => 102928 
```
二进制：
```ruby
2.4.1 :003 > 0b10010110
 => 150 
```
八进制：
```ruby
2.4.1 :005 > 01234
 => 668 
```
十六进制：
```ruby
2.4.1 :006 > 0xdeadbeef
 => 3735928559 
```

#### 基本数值计算：
幂：  
```ruby
2.4.1 :008 > a = 7**2
 => 49 
```

浮点数计算：
1. 使用to_f
2. 使用小数点 .

#### 对浮点数进行舍入：
1. 使用round  
例如：  
```ruby
2.4.1 :009 > pi = 3.1415926
 => 3.1415926 
2.4.1 :010 > pi.round
 => 3 
```
2. 如果想要的不是整型而是得到特定小数位数：  
可以使用sprintf 和eval方法实现
```ruby
2.4.1 :011 > pi = 3.1415926
 => 3.1415926 
2.4.1 :012 > pi6 = eval(sprintf("%8.6f",pi))
 => 3.141593 
2.4.1 :013 > pi5 = eval(sprintf("%8.5f",pi))
 => 3.14159 
```
3. 定义一个方法进行换算：
```ruby
class Float
  
  def roundf(places)
  	temp = self.to_s.length
  	sprintf("%#{temp}.#{places}f",self).to_f
  end

end

pi = 3.1415926
puts pi.roundf(3)
```

#### 比较浮点数：
```ruby
class Float
  
  lsb = 1e-6

  def ==(x)
  	(self-x).abs < lsb
  end

end

x = 1000001.0/0.003
y = 0.003 *x

if y == 1.0
  puts "yes"
else
  puts "no"
end
```
#### 处理有理数：

```ruby
r = Rational(1,2)
s = Rational(1,3)
puts r+s
#=>5/6
```

#### 矩阵运算：
创建单位矩阵：（使用矩阵必须使用Matrix库）  
```ruby
2.4.1 :001 > require 'Matrix'
 => true 
2.4.1 :002 > Matrix.identity(3)
 => Matrix[[1, 0, 0], [0, 1, 0], [0, 0, 1]] 
2.4.1 :003 > Matrix.I(3)
 => Matrix[[1, 0, 0], [0, 1, 0], [0, 0, 1]] 
2.4.1 :004 > Matrix.unit(3)
 => Matrix[[1, 0, 0], [0, 1, 0], [0, 0, 1]] 
```

创建主对角线矩阵，可以定义主对角线上的数字：  
```ruby
irb(main):003:0> sm = Matrix.scalar(3,5)
=> Matrix[[5, 0, 0], [0, 5, 0], [0, 0, 5]]
irb(main):004:0> sm = Matrix.diagonal(3,5,7)
=> Matrix[[3, 0, 0], [0, 5, 0], [0, 0, 7]]
irb(main):005:0> sm = Matrix.zero(3)
=> Matrix[[0, 0, 0], [0, 0, 0], [0, 0, 0]]
```

创建单列或单行矩阵：  
```ruby
irb(main):023:0> b = Matrix.column_vector([2,3,4,5])
=> Matrix[[2], [3], [4], [5]]
irb(main):024:0> b = Matrix.row_vector([2,3,4,5])
=> Matrix[[2, 3, 4, 5]]
```

使用Matrix创建并索引（注意索引的范围从0开始）：  
```ruby
irb(main):033:0> b = Matrix[[1,2,3],[4,5,6],[7,8,9]]
=> Matrix[[1, 2, 3], [4, 5, 6], [7, 8, 9]]
irb(main):034:0> b[0,0]
=> 1
irb(main):035:0> b[1,0]
=> 4
```

使用.row_vectors、.column_vectors、minor获取矩阵部分元素
```ruby
irb(main):036:0> b = Matrix[[1,2,3],[4,5,6],[7,8,9]]
=> Matrix[[1, 2, 3], [4, 5, 6], [7, 8, 9]]
irb(main):037:0> b.row_vectors
=> [Vector[1, 2, 3], Vector[4, 5, 6], Vector[7, 8, 9]]
irb(main):038:0> b.column_vectors
=> [Vector[1, 4, 7], Vector[2, 5, 8], Vector[3, 6, 9]]
irb(main):039:0> b.minor(0..1,0..1)  #参数为行和列的范围
=> Matrix[[1, 2], [4, 5]]
```

将长为N的向量转换为Nx1的矩阵
```ruby
irb(main):045:0> v = Vector[2,3,5]
=> Vector[2, 3, 5]
irb(main):046:0> v.covector
=> Matrix[[2, 3, 5]]
```

矩阵乘法:
```ruby
irb(main):047:0> v = Matrix[[1,0,0],[0,2,0],[0,0,3]]
=> Matrix[[1, 0, 0], [0, 2, 0], [0, 0, 3]]
irb(main):048:0> b
=> Matrix[[1, 2, 3], [4, 5, 6], [7, 8, 9]]
irb(main):049:0> b*v
=> Matrix[[1, 4, 9], [4, 10, 18], [7, 16, 27]]
```

#### 处理复数：  
使用标准库complex  
```ruby
irb(main):001:0> z = Complex(1,2)
=> (1+2i)
irb(main):002:0> z = 1+2.i
=> (1+2i)
irb(main):003:0> z = Complex.polar(5,Math::PI/2.0)
=> (0.0+5i)   #极坐标表示法
```


#### 使用mathn库进行数值计算

```ruby
require 'mathn'
```
好处：非常有效的支持了有理数：  
```ruby
irb(main):001:0> Math.sqrt(Rational(9,16))
=> 0.75
irb(main):002:0> require 'mathn'
=> true
irb(main):003:0> Math.sqrt(Rational(9,16))
=> (3/4)
```

#### 








































