# FLOATS
# casting to a string to float using .to_f method
"25.58".to_f # output = 25.58
# or Float("25.58") 

# Note, there is a difference when the string is not a valid Float:
"something".to_f # output = 0.0
# or Float("something") 
# ArgumentError: invalid value for Float(): "something"

# STRINGS
123.5.to_s #=> "123.5"
# String(123.5) #=> "123.5"

#  Usually, String() will just call #to_s.
# Methods Kernel #sprintf and String#% behave similar to C:

sprintf("%s", 123.5) #=> "123.5"
# "%s" % 123.5 #=> "123.5"
# "%d" % 123.5 #=> "123"
# "%.2f" % 123.5 #=> "123.50"

# INTEGER
"123.50".to_i #=> 123
Integer("123") #=> 123

# A string will take the value of any integer at its start, but will not take integers from anywhere else:

# "123-foo".to_i # => 123
# "foo-123".to_i # => 0

# However, there is a difference when the string is not a valid Integer:
# "something".to_i #=> 0

# Integer("something") # ArgumentError: invalid value for Integer(): "something"

# FLOATS AND INTEGERS
# 1/2 #=> 0

# Since we are dividing two integers, the result is an integers
# To solve this problems, we need to cast at least one of those to Float

# 1.0 / 2 #=> 0.5
# 1.to_f / 2 #=> 0.5
# 1 / Float(2) #=> 0.5

# Alternatively, .fdiv may be used 
# to return the floating point result of division without explicitly casting either operand

# puts 1.fdiv 2 #=> 0.5