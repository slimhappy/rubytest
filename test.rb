def calculate(op1,operator,op2)
	string = op1.to_s + operator + op2.to_s
	eval(string)
end
@alpha = 25
@beta = 12
puts calculate(2,"+",2)
puts calculate(5,"*","@alpha")
