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




























