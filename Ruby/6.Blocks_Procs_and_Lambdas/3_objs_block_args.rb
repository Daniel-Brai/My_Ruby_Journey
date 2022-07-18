# Objects as block arguments to methods
# Putting a & (ampersand) in front of an argument will pass it as the method's block. Objects will be converted to a
Proc using the to_proc method.
class Greeter
 def to_proc
 Proc.new do |item|
 puts "Hello, #{item}"
 end
 end
end
greet = Greeter.new
%w(world life).each(&greet)

# This is a common pattern in Ruby and many standard classes provide it.
# For example, Symbols implement to_proc by sending themselves to the argument:
# Example implementation
class Symbol
 def to_proc
 Proc.new do |receiver|
 receiver.send self
 end
 end
end
# This enables the useful &:symbol idiom, commonly used with Enumerable objects:
letter_counts = %w(just some words).map(&:length) # [4, 4, 5]
