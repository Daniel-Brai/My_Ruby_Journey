# IF, ELSIF, ELSE & END

# 1: IF EXPRESSION
# Ruby offers the expected if and else expressions for branching logic, terminated by the end keyword:
# The simplest if expression has two parts, a “test” expression and a “then” expression. 
# If the “test” expression evaluates to a true then the “then” expression is evaluated.

# Here is a simple if statement:

if true then
  puts "the test resulted in a true-value"
end

# This will print “the test resulted in a true-value”.

# The then is optional:

if true
  puts "the test resulted in a true-value"
end


# Simulate flipping a coin

result = [:heads, :tails].sample
if result == :heads
 puts 'The coin-toss came up "heads"'
else
 puts 'The coin-toss came up "tails"'
end

# In Ruby, if statements are expressions that evaluate to a value, and the result can be assigned to a variable:

# status = if age < 18
#             :minor
#         else
#             :adult
#         end

# Ruby also offers C-style ternary operators (see here for details) that can be expressed as:

# some_statement ? if_true : if_false 

# This means the above example using if-else can also be written as
# status = age < 18 ? :minor : :adult

# 2: IF ELSE EXPRESSION
# You may also add an else expression. If the test does not evaluate to true the else expression will be executed:

if false
  puts "the test resulted in a true-value"
else
  puts "the test resulted in a false-value"
end

# This will print “the test resulted in a false-value”.

# 3: ELSIF EXPRESSION
# You may add an arbitrary number of extra tests to an if expression using elsif. An elsif executes when all tests above the elsif are false.

a = 1

if a == 0
  puts "a is zero"
elsif a == 1
  puts "a is one"
else
  puts "a is some other value"
end

# This will print “a is one” as 1 is not equal to 0. Since else is only executed when there are no matching conditions.

# Once a condition matches, either the if condition or any elsif condition, the if expression is complete and no further tests will be performed.

# Like an if, an elsif condition may be followed by a then.

# In this example only “a is one” is printed:

a = 1

if a == 0
  puts "a is zero"
elsif a == 1
  puts "a is one"
elsif a >= 1
  puts "a is greater than or equal to one"
else
  puts "a is some other value"
end

# Additionally, the elsif keyword which accepts an expression to enables additional branching logic:
label = if shirt_size == :s
            'small'
        elsif shirt_size == :m
            'medium'
        elsif shirt_size == :l
            'large'
        else
            'unknown size'
        end

# If none of the conditions in an if/elsif chain are true, and there is no else clause, then the expression evaluates to nil. 
# This can be useful inside string interpolation, since nil.to_s is the empty string:
"user#{'s' if @users.size != 1}"

# 4:  TERNARY IF
# You may also write a if-then-else expression using ? and :. 
# This ternary if:

input_type = gets =~ /hello/i ? "greeting" : "other"

# Is the same as this if expression:

input_type =
  if gets =~ /hello/i
    "greeting"
  else
    "other"
  end

# While the ternary if is much shorter to write than the more verbose form, for readability it is recommended that the ternary if is only used for simple conditionals. 
# Also, avoid using multiple ternary conditions in the same expression as this can be confusing.

# 5: UNLESS EXPRESSION
# The unless expression is the opposite of the if expression.
# If the value is false, the “then” expression is executed:

unless true
  puts "the value is a false-value"
end

# This prints nothing as true is not a false-value.

# You may use an optional then with unless just like if.

# Note that the above unless expression is the same as:

if not true
  puts "the value is a false-value"
end

# Like an if expression you may use an else condition with unless:

unless true
  puts "the value is false"
else
  puts "the value is true"
end

# This prints “the value is true” from the else condition.

# NOTE: You may not use elsif with an unless expression.
# The result value of an unless expression is the last value executed in the expression.

# 6: MODIFIER IF AND UNLESS

# if and unless can also be used to modify an expression.
# When used as a modifier the left-hand side is the “then” statement and the right-hand side is the “test” expression:

# For example: 
# modifier if
a = 0
a += 1 if a.zero?
p a

# This will print 1.

# modifier unless
a = 0
a += 1 unless a.zero?
p a

# This will print 0.

# NOTE: While the modifier and standard versions have both a “test” expression and a “then” statement,
# they are not exact transformations of each other due to parse order. 
# Here is an example that shows the difference:

p a if a = 0.zero?
# This raises the NameError “undefined local variable or method ‘a’”.
# When ruby parses this expression it first encounters a as a method call in the “then” expression, then later it sees the assignment to a in the “test” expression and marks a as a local variable.
# When running this line it first executes the “test” expression, a = 0.zero?.

# Since the test is true it executes the “then” expression, p a. Since the a in the body was recorded as a method which does not exist the NameError is raised.
# The same is true for unless.

# 7: CASE EXPRESSION

# Ruby uses the case keyword for switch statements

# As per the Ruby Docs:
# Case statements consist of an optional condition, which is in the position of an argument to case, and
# zero or more when clauses. The first when clause to match the condition (or to evaluate to Boolean truth, if
# the condition is null) “wins”, and its code stanza is executed. The value of the case statement is the value
# of the successful when clause, or nil if there is no such clause.
# A case statement can end with an else clause. Each when a statement can have multiple candidate values,
# separated by commas.
# Example:

case x
when 1,2,3
    puts "1, 2, or 3"
when 10
    puts "10"
else
    puts "Some other number"
end

# Shorter version:
case x
when 1,2,3 then puts "1, 2, or 3"
when 10 then puts "10"
else puts "Some other number"
end

# The value of the case clause is matched with each when clause using the === method (not ==). Therefore it can be
# used with a variety of different types of objects.

# A case statement can be used with Ranges:
case 17
when 13..19
 puts "teenager"
end

# A case statement can be used with a Regexp:
case "google"
when /oo/
 puts "word contains oo"
end

# A case statement can be used with a Proc or lambda:
case 44
when -> (n) { n.even? or n < 0 }
 puts "even or less than zero"
end

# A case statement can be used with Classes:
case x
when Integer
 puts "It's an integer"
when String
 puts "It's a string"
end

# By implementing the === method you can create your own match classes:
class Empty
 def self.===(object)
   !object or "" == object
 end
end

case ""
when Empty
 puts "name was empty"
else
 puts "name is not empty"
end

# A case statement can be used without a value to match against:
case
when ENV['A'] == 'Y'
 puts 'A'
when ENV['B'] == 'Y'
 puts 'B'
else
 puts 'Neither A nor B'
end

# A case statement has a value, so you can use it as a method argument or in an assignment:
description = case 16
              when 13..19 then "teenager"
              else ""
              end

# 8. TRUTHY AND FALSY VALUES

# In Ruby, there are exactly two values which are considered "falsy", and will return false when tested as a condition
# for an if expression. They are:
# a. nil
# b. boolean false

# All other values are considered "truthy", including:
# a. 0 - numeric zero (Integer or otherwise)
# b. "" - Empty strings
# c. "\n" - Strings containing only whitespace
# d. [] - Empty arrays
# e. {} - Empty hashes

# Take, for example, the following code:
def check_truthy(var_name, var)
 is_truthy = var ? "truthy" : "falsy"
 puts "#{var_name} is #{is_truthy}"
end

check_truthy("false", false)
check_truthy("nil", nil)
check_truthy("0", 0)
check_truthy("empty string", "")
check_truthy("\\n", "\n")
check_truthy("empty array", [])
check_truthy("empty hash", {})

# Will output:
# false is falsy
# nil is falsy
# 0 is truthy
# empty string is truthy
# \n is truthy
# empty array is truthy
# empty hash is truthy

# 9: WHILE LOOP

# The while loop executes while a condition is true:

a = 0

while a < 10 do
  p a
  a += 1
end

p a

# Prints the numbers 0 through 10. 
# The condition a < 10 is checked before the loop is entered, then the body executes, then the condition is checked again. When the condition results in false the loop is terminated.

# The do keyword is optional. The following loop is equivalent to the loop above:

while a < 10
  p a
  a += 1
end

# The result of a while loop is nil unless break is used to supply a value.

# 10: UNTIL LOOP
# The until loop executes while a condition is false:

a = 0

until a > 10 do
  p a
  a += 1
end

p a

# This prints the numbers 0 through 11. 
# Like a while loop the condition a > 10 is checked when entering the loop and each time the loop body executes. 
# If the condition is false the loop will continue to execute.
# Like a while loop, the do is optional.

# Like a while loop, the result of an until loop is nil unless break is used.


# 11: FLIP FLOP OPERATOR

# The flip flop operator .. is used between two conditions in a conditional statement:
# For example
(1..5).select do |e|
  e if (e == 2) .. (e == 4)
end
# => [2, 3, 4]

# The condition evaluates to false until the first part becomes true. Then it evaluates to true until the second part
# becomes true. After that it switches to false again.
# This example illustrates what is being selected:
[1, 2, 2, 3, 4, 4, 5].select do |e|
 e if (e == 2) .. (e == 4)
end
# => [2, 2, 3, 4]

# The flip-flop operator only works inside ifs (including unless) and ternary operator. Otherwise it is being considered
as the range operator.
(1..5).select do |e|
 (e == 2) .. (e == 4)
end
# => ArgumentError: bad value for range

# It can switch from false to true and backwards multiple times:
((1..5).to_a * 2).select do |e|
 e if (e == 2) .. (e == 4)
end
# => [2, 3, 4, 2, 3, 4]

# 12: Or-Equals/Conditional assignment operator (||=)
# Ruby has an or-equals operator that allows a value to be assigned to a variable if and only if that variable evaluates
# to either nil or false.
# ||= # this is the operator that achieves this.

# this operator with the double pipes representing or and the equals sign representing assigning of a value. You may
# think it represents something like this:
 x = x || y

#  this above example is not correct. The or-equals operator actually represents this:
 x || x = y

#  If x evaluates to nil or false then x is assigned the value of y, and left unchanged otherwise.
# Here is a practical use-case of the or-equals operator. Imagine you have a portion of your code that is expected to
# send an email to a user. What do you do if for what ever reason there is no email for this user. You might write
# something like this:
if user_email.nil?
 user_email = "error@yourapp.com"
end

# Using the or-equals operator we can cut this entire chunk of code, providing clean, clear control and functionality.
 user_email ||= "error@yourapp.com"

#  In cases where false is a valid value, care must be taken to not override it accidentally:
has_been_run = false
has_been_run ||= true
#=> true
has_been_run = false
has_been_run = true if has_been_run.nil?
#=> false
 
# 13: MODIFIER WHILE AND UNTIL
# Like if and unless, while and until can be used as modifiers:
# For example
a = 0
a += 1 while a < 10
p a # prints 10

# until used as a modifier:
a = 0
a += 1 until a > 10
p a # prints 11

# You can use begin and end to create a while loop that runs the body once before the condition:

a = 0
begin
  a += 1
end while a < 10

p a # prints 10

# If you don’t use rescue or ensure, Ruby optimizes away any exception handling overhead.

#  14: Loop control with break, next, and redo
# The flow of execution of a Ruby block may be controlled with the break, next, and redo statements.
# break: 
# The break statement will exit the block immediately. Any remaining instructions in the block will be skipped, and
# the iteration will end:
actions = %w(run jump swim exit macarena)
index = 0
while index < actions.length
 action = actions[index]
 break if action == "exit"
 index += 1
 puts "Currently doing this action: #{action}"
end
# Currently doing this action: run
# Currently doing this action: jump
# Currently doing this action: swim

# next
# The next statement will return to the top of the block immediately, and proceed with the next iteration. Any
# remaining instructions in the block will be skipped:
actions = %w(run jump swim rest macarena)
index = 0
while index < actions.length
 action = actions[index]
 index += 1
 next if action == "rest"
 puts "Currently doing this action: #{action}"
end
# Currently doing this action: run
# Currently doing this action: jump
# Currently doing this action: swim
# Currently doing this action: macarena

# redo
# The redo statement will return to the top of the block immediately, and retry the same iteration. Any remaining
# instructions in the block will be skipped:
actions = %w(run jump swim sleep macarena)
index = 0
repeat_count = 0
while index < actions.length
 action = actions[index]
 puts "Currently doing this action: #{action}"
 if action == "sleep"
 repeat_count += 1
 redo if repeat_count < 3
 end
 index += 1
end
# Currently doing this action: run
# Currently doing this action: jump
# Currently doing this action: swim
# Currently doing this action: sleep
# Currently doing this action: sleep
# Currently doing this action: sleep
# Currently doing this action: macarena

# Enumerable iteration
# In addition to loops, these statements work with Enumerable iteration methods, such as each and map:
[1, 2, 3].each do |item|
 next if item.even?
 puts "Item: #{item}"
end
# Item: 1
# Item: 3

# Block result values
# In both the break and next statements, a value may be provided, and will be used as a block result value:
even_value = for value in [1, 2, 3]
 break value if value.even?
end
puts "The first even value is: #{even_value}"
# The first even value is: 2

# 15: return vs. next: non-local return in a block
# Consider this broken snippet:
def foo
 bar = [1, 2, 3, 4].map do |x|
 return 0 if x.even?
 x
 end
 puts 'baz'
 bar
end
foo # => 0

# One might expect return to yield a value for map's array of block results. 
# So the return value of foo would be [1, 0, 3, 0]. 
# Instead, return returns a value from the method foo. 
# Notice that baz isn't printed, which means execution never reached that line.
# next with a value does the trick. It acts as a block-level return.
def foo
 bar = [1, 2, 3, 4].map do |x|
 next 0 if x.even?
 x
 end
 puts 'baz'
 bar
end
foo # baz
 # => [1, 0, 3, 0]

#  In the absence of a return, the value returned by the block is the value of its last expression.

# 15: begin, end
# The begin block is a control structure that groups together multiple statements.
begin
 a = 7
 b = 6
 a * b
end

# A begin block will return the value of the last statement in the block. The following example will return 3.
begin
 1
 2
 3
end

# The begin block is useful for conditional assignment using the ||= operator where multiple statements may be
# required to return a result.

circumference ||=
begin
  radius = 7
  tau = Math::PI * 2
  tau * radius
end

# It can also be combined with other block structures such as rescue, ensure, while, if, unless, etc to provide
# greater control of program flow.
# Begin blocks are not code blocks, like { ... } or do ... end; they cannot be passed to functions

# 16: for Loop
# The for loop consists of for followed by a variable to contain the iteration argument followed by in and the value to iterate over using each. The do is optional:
  
for value in [1, 2, 3] do
  puts value
end
  
# Prints 1, 2 and 3.
  
# Like while and until, the do is optional.
  
# The for loop is similar to using each, but does not create a new variable scope.

# The result value of a for loop is the value iterated over unless break is used.

# The for loop is rarely used in modern ruby programs.

# 17: Control flow with logic statements
# While it might seem counterintuitive, you can use logical operators to determine whether or not a statement is run.
# For instance:
File.exist?(filename) or STDERR.puts "#{filename} does not exist!"

# This will check to see if the file exists and only print the error message if it doesn't. The or statement is lazy, which
# means it'll stop executing once it's sure which whether it's value is true or false. As soon as the first term is found to
# be true, there's no need to check the value of the other term. But if the first term is false, it must check the second
# term.
# A common use is to set a default value:
glass = glass or 'full' # Optimist!

# That sets the value of glass to 'full' if it's not already set. More concisely, you can use the symbolic version of or:
# glass ||= 'empty' # Pessimist.
# It's also possible to run the second statement only if the first one is false:
# File.exist?(filename) and puts "#{filename} found!"
# Again, and is lazy so it will only execute the second statement if necessary to arrive at a value.
# The or operator has lower precedence than and. Similarly, || has lower precedence than &&. The symbol forms
# have higher precedence than the word forms. This is handy to know when you want to mix this technique with
# assignment:
a = 1 and b = 2
#=> a==1
#=> b==2
a = 1 && b = 2; puts a, b
#=> a==2
#=> b==2

# Note that the Ruby Style Guide recommends:
# The and and or keywords are banned. The minimal added readability is just not worth the high probability
# of introducing subtle bugs. For boolean expressions, always use && and || instead. For flow control, use
# if and unless; && and || are also acceptable but less clear