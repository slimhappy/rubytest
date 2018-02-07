def my_sequence
	for i in 1..10 do
		yield i
	end
end

my_sequence{|x| puts x**3}

def some_method
	#code
rescue
	#recovery
end