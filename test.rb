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