# OPERATOR PRECEDENCE AND METHODS
# From highest to  lowest, this is the precedence table for Ruby. High precedence operations happen before low
# precedence operations.

# ╔═══════════════════════════════════════════════════════════════════════════════════
# ║ Operators           ║ Operations                             ║    Method?   ║
# ╠═══════════════════════════════════════════════════════════════════════════════════
# ║ .                   ║ Method call (e.g. foo.bar)             ║              ║
# ║ [] []=              ║ Bracket Lookup, Bracket Set            ║ ✓¹           ║
# ║ ! ~ +               ║ Boolean NOT, complement, unary plus    ║ ✓²           ║
# ║ **                  ║ Exponentiation                         ║ ✓            ║
# ║ -                   ║ Unary minus                            ║ ✓²           ║
# ║ * / %               ║ Multiplication, division, modulo       ║ ✓            ║
# ║ + -                 ║ Addition, subtraction                  ║ ✓            ║
# ║ <>                  ║ Bitwise shift                          ║ ✓            ║
# ║ &                   ║ Bitwise AND                            ║ ✓            ║
# ║ | ^                 ║ Bitwise OR, Bitwise XOR                ║ ✓            ║
# ║ < <= >= >           ║ Comparison                             ║ ✓            ║
# ║ <=> == != === =~ !~ ║ Equality, pattern matching, comparison ║ ✓³           ║
# ║ &&                  ║ Boolean AND                            ║              ║
# ║ ||                  ║ Boolean OR                             ║              ║
# ║ .. ...              ║ Inclusive range, Exclusive range       ║              ║
# ║ ? :                 ║ Ternary operator                       ║              ║
# ║ rescue              ║ Modifier rescue                        ║              ║
# ║ = += -=             ║ Assignments                            ║              ║
# ║ defined?            ║ Defined operator                       ║              ║
# ║ not                 ║ Boolean NOT                            ║              ║
# ║ or and              ║ Boolean OR, Boolean AND                ║              ║
# ║ if unless while until ║ Modifier if, unless, while, until    ║              ║
# ║ { }                 ║ Block with braces                      ║              ║
# ║ do end              ║ Block with do end                      ║              ║
# ╚══════════════════════════════════════════════════════════════════════════════════╝

# Unary + and unary - are for +obj, -obj or -(some_expression).
# Modifier-if, modifier-unless, etc. are for the modifier versions of those keywords.
# For example, this is a modifier-unless expression:

# a += 1 unless a.zero?

#  Operators with a ✓ may be defined as methods. Most methods are named exactly as the operator is named, for
# example:

# class Foo
#     def **(x)
#         puts "Raising to the power of #{x}"
#     end
#     def <<(y)
#         puts "Shifting left by #{y}"
#     end
#     def !
#         puts "Boolean negation"
#     end
# end

# Foo.new ** 2 #=> "Raising to the power of 2"
# Foo.new << 3 #=> "Shifting left by 3"
# !Foo.new #=> "Boolean negation"

# The Bracket Lookup and Bracket Set methods ([] and []=) have their arguments defined after the name, for
#  example:

# class Foo
#     def [](x)
#         puts "Looking up item #{x}"
#     end
#     def []=(x,y)
#         puts "Setting item #{x} to #{y}"
#     end
# end

# f = Foo.new
# f[:cats] = 42 #=> "Setting item cats to 42"
# f[17] #=> "Looking up item 17"

# The "unary plus" and "unary minus" operators are defined as methods named +@ and -@, for example

# class Foo
#     def -@
#         puts "unary minus"
#     end
#     def +@
#         puts "unary plus"
#     end
# end

# f = Foo.new
# +f #=> "unary plus"
# -f #=> "unary minus"

# In early versions of Ruby the inequality operator != and the non-matching operator !~ could not be defined as
# methods. Instead, the method for the corresponding equality operator == or matching operator =~ was invoked,
# and the result of that method was boolean inverted by Ruby.
# If you do not define your own != or !~ operators the above behavior is still true. However, as of Ruby 1.9.1, those
# two operators may also be defined as methods:

# class Foo
#     def ==(x)
#       puts "checking for EQUALITY with #{x}, returning false"
#       false
#     end
# end

# f = Foo.new
# x = (f == 42) #=> "checking for EQUALITY with 42, returning false"
# puts x #=> "false"
# x = (f != 42) #=> "checking for EQUALITY with 42, returning false"
# puts x #=> "true"

# class Foo
#     def !=(x)
#       puts "Checking for INequality with #{x}"
#     end
# end

# f != 42 #=> "checking for INequality with 42"

# THE CASE EQUALITY OPERATOR (===)
# Also known as triple equals.
# This operator does not test equality, but rather tests if the right operand has an IS A relationship with the left
# operand.
# As such, the popular name case equality operator is misleading.
# This SO answer describes it thus: 
# the best way to describe a === b is "if I have a drawer labeled a, does it make sense to put b in it?" 
# In other words, does the set a include the member b?
# Examples (source)

# (1..5) === 3 # => true
# (1..5) === 6 # => false
# Integer === 42 # => true
# Integer === 'fourtytwo' # => false
# /ell/ === 'Hello' # => true
# /ell/ === 'Foobar' # => false

# Classes that override ===

# Many classes override === to provide meaningful semantics in case statements. 
# Some of them are:

# ╔════════════════════════════════
# ║ Class        ║ Synonym for   ║
# ╠════════════════════════════════
# ║ Array        ║      ==       ║
# ║              ║               ║
# ║ Date         ║      ==       ║
# ║              ║               ║
# ║ Module       ║    is_a?      ║
# ║              ║               ║
# ║ Object       ║      ==       ║
# ║              ║               ║
# ║ Range        ║    include?   ║
# ║              ║               ║
# ║ Regexp       ║ =~            ║
# ║              ║               ║
# ║ String       ║ ==            ║
# ╚════════════════════════════════╝

# Recommended practice
# Explicit use of the case equality operator === should be avoided. 
# It doesn't test equality but rather subsumption, and its use can be confusing. 
# Code is clearer and easier to understand when the synonym method is used instead

# Bad
# Integer === 42
# (1..5) === 3
# /ell/ === 'Hello'

# Good, uses synonym method
# 42.is_a?(Integer)
# (1..5).include?(3)
# /ell/ =~ 'Hello'

# THE SAFE NAVIGATION OPERATOR

# Ruby 2.3.0 added the safe navigation operator, &. 
# This operator is intended to shorten the paradigm of object && object.property && object.property.method in conditional statements.

# For example, you have a House object with an address property, and you want to find the street_name from the address. To program this safely to avoid nil errors in older Ruby versions, you'd use code something like this:

# if house && house.address && house.address.street_name
#     house.address.street_name
# end

# The safe navigation operator shortens this condition. 
# Instead, you can write:

# if house&.address&.street_name
#     house.address.street_name
# end

# Caution:
# The safe navigation operator doesn't have exactly the same behavior as the chained conditional. 
# Using the chained conditional (first example), 
# the if block would not be executed if, say address was false. 
# The safe navigation operator only recognises nil values, but permits values such as false. 
# If address is false, using the SNO will yield an error:

# house&.address&.street_name
# # => undefined method `address' for false:FalseClass

# ASSIGNMENT OPERATORS

#  1. Simple Assignment
# = is a simple assignment. It creates a new local variable if the variable was not previously referenced.

# x = 3
# y = 4 + 5
# puts "x is #{x}, y is #{y}"

# This will output:
# x is 3, y is 9

# 2. Parallel Assignment
# Variables can also be assigned in parallel, e.g. x, y = 3, 9. 
# This is especially useful for swapping values:

# x, y = 3, 9
# x, y = y, x
# puts "x is #{x}, y is #{y}"

# This will output:
# x is 9, y is 3

# 3. Abbreviated Assignment
# It's possible to mix operators and assignment. 
# For example:

# x = 1
# y = 2
# puts "x is #{x}, y is #{y}"

# x += y
# puts "x is now #{x}"

# Shows the following output:
# x is 1, y is 2
# x is now 3

# Various operations can be used in abbreviated assignment:
# Operator       Description                                                  Example Equivalent to
# +=             Adds and reassigns the variable                              x += y x = x + y
# -=             Subtracts and reassigns the variable                         x -= y x = x - y
# *=             Multiplies and reassigns the variable                        x *= y x = x * y
# /=             Divides and reassigns the variable                           x /= y x = x / y
# %=             Divides, takes the remainder, and reassigns the variable     x %= y x = x % y
# **=            Calculates the exponent and reassigns the variable           x **= y x = x ** y

#  COMPARISON OPERATORS

# Operator    Description
# ==          true if the two values are equal.

# !=          true if the two values are not equal.

# <           true if the value of the operand on the left is less than the value on the right.

# >           true if the value of the operand on the left is greater than the value on the right.

# >=          true if the value of the operand on the left is greater than or equal to the value on the right.

# <=          true if the value of the operand on the left is less than or equal to the value on the right.

# <=>         0 if the value of the operand on the left is equal to the value on the right,
             # 1 if the value of the operand on the left is greater than the value on the right,
             #-1 if the value of the operand on the left is less than the value on the right
