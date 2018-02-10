class String

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
