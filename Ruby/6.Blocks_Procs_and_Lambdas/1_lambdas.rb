# 1: Lambdas
# lambda using the arrow syntax
hello_world = -> { 'Hello World!' }
p hello_world[]
# 'Hello World!'

# lambda using the arrow syntax accepting 1 argument
hello_name = ->(name) { "Hello #{name}!" }
p hello_name['Daniel Brai']
# "Hello Daniel Brai!"

# the_thing = lambda do |magic, ohai, dere|
#  puts "magic! #{magic}"
#  puts "ohai #{dere}"
#  puts "#{ohai} means hello"
# end

# p the_thing.call(1, 2, 3)
# # magic! 1
# # ohai 3
# # 2 means hello

# p the_thing.call(1, 2)
# # ArgumentError: wrong number of arguments (2 for 3)

# p the_thing[1, 2, 3, 4]
# # ArgumentError: wrong number of arguments (4 for 3)

# You can also use -> to create and .() to call lambda

# the_thing = ->(magic, ohai, dere) {
#  puts "magic! #{magic}"
#  puts "ohai #{dere}"
#  puts "#{ohai} means hello"
# }

# p the_thing.(1, 2, 3)
# # => magic! 1
# # => ohai 3
# # => 2 means hello

# Here you can see that a lambda is almost the same as a proc. However, there are several caveats:
# The arity of a lambda's arguments are enforced; passing the wrong number of arguments to a lambda, will
# raise an ArgumentError. They can still have default parameters, splat parameters, etc.
# returning from within a lambda returns from the lambda, while returning from a proc returns out of the
# enclosing scope:

def try_proc
 x = Proc.new {
 return # Return from try_proc
 }
 x.call
 puts "After x.call" # this line is never reached
end

def try_lambda
 y = -> {
 return # return from y
 }
 y.call
 puts "After y.call" # this line is not skipped
end

p try_proc # No output
p try_lambda # Outputs "After y.call"