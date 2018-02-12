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
