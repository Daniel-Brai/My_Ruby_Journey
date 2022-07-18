# Blocks
# Blocks are chunks of code enclosed between braces {} (usually for single-line blocks) or do..end (used for multi-line
# blocks).
5.times { puts "Hello world" } # recommended style for single line blocks

5.times do
 print "Hello "
 puts "world"
end # recommended style for multi-line blocks

5.times {
 print "hello "
 puts "world" } # does not throw an error but is not recommended


# Note: braces have higher precedence than do..end

# Yielding
# Blocks can be used inside methods and functions using the word yield:
def block_caller
 puts "some code"
 yield
 puts "other code"
end
block_caller { puts "My own block" } # the block is passed as an argument to the method.
#some code
#My own block
#other code

# Be careful though if yield is called without a block it will raise a LocalJumpError. For this purpose ruby provides
# another method called block_given? this allows you to check if a block was passed before calling yield
def block_caller
 puts "some code"
 if block_given?
 yield
 else
 puts "default"
 end
 puts "other code"
end
block_caller
# some code
# default
# other code

block_caller { puts "not defaulted"}
# some code
# not defaulted
# other code

# yield can offer arguments to the block as well
def yield_n(n)
 p = yield n if block_given?
 p || n
end
yield_n(12) {|n| n + 7 }
#=> 19
yield_n(4)
#=> 4

# While this is a simple example yielding can be very useful for allowing direct access to instance variables or
# evaluations inside the context of another object. For Example:
class Application
 def configuration
 @configuration ||= Configuration.new
 block_given? ? yield(@configuration) : @configuration
 end
end

class Configuration; end
app = Application.new
app.configuration do |config|
 puts config.class.name
end

# Configuration
#=> nil
app.configuration
#=> #<Configuration:0x2bf1d30>

# As you can see using yield in this manner makes the code more readable than continually calling
# app.configuration.#method_name. Instead you can perform all the configuration inside the block keeping the code
# contained.

# Variables
# Variables for blocks are local to the block (similar to the variables of functions), they die when the block is executed.
my_variable = 8
3.times do |x|
 my_variable = x
 puts my_variable
end
puts my_variable
#=> 0
# 1
# 2
# 8

# Blocks can't be saved, they die once executed. In order to save blocks you need to use procs and lambdas.
