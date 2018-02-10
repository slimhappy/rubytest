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








