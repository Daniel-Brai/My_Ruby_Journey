# METHODS

# Functions in Ruby provide organized, reusable code to preform a set of actions.
# Functions simplify the coding process, prevent redundant logic, and make code easier to follow.
# This topic describes the declaration and utilization of functions, arguments, parameters, yield statements and scope in Ruby.

# 1: Defining a method
# Methods are defined with the def keyword, followed by the method name and an optional list of parameter names in
# parentheses. The Ruby code between def and end represents the body of the method.
def hello(name)
 "Hello, #{name}"
end

# A method invocation specifies the method name, the object on which it is to be invoked (sometimes called the
# receiver), and zero or more argument values that are assigned to the named method parameters.
hello("World")
# => "Hello, World"

# When the receiver is not explicit, it is self.
# Parameter names can be used as variables within the method body, and the values of these named parameters
# come from the arguments to a method invocation.
hello("World")
# => "Hello, World"
hello("All")
# => "Hello, All"

# 2: Yielding to blocks
# You can send a block to your method and it can call that block multiple times. 
# This can be done by sending a proc/lambda or such, but is easier and faster with yield:
def simple(arg1,arg2)
 puts "First we are here: #{arg1}"
 yield
 puts "Finally we are here: #{arg2}"
 yield
end
simple('start','end') { puts "Now we are inside the yield" }
#> First we are here: start
#> Now we are inside the yield
#> Finally we are here: end
#> Now we are inside the yield

# Note that the { puts ... } is not inside the parentheses, it implicitly comes after. 
# This also means we can only have one yield block. 
# We can pass arguments to the yield:
def simple(arg)
 puts "Before yield"
 yield(arg)
 puts "After yield"
end
simple('Dave') { |name| puts "My name is #{name}" }
#> Before yield
#> My name is Dave
#> After yield


# With yield we can easily make iterators or any functions that work on other code:
def countdown(num)
 num.times do |i|
 yield(num-i)
 end
end
countdown(5) { |i| puts "Call number #{i}" }
#> Call number 5
#> Call number 4
#> Call number 3
#> Call number 2
#> Call number 1


# In fact, it is with yield that things like foreach, each and times are generally implemented in classes.
# If you want to find out if you have been given a block or not, use block_given?:
class Employees
 def names
 ret = []
 @employees.each do |emp|
 if block_given?
 yield(emp.name)
 else
 ret.push(emp.name)
 end
 end
 ret
 end
end


# This example assumes that the Employees class has an @employees list that can be iterated with each to get objects
# that have employee names using the name method. If we are given a block, then we'll yield the name to the block,
# otherwise we just push it to an array that we return.

# 3: Default parameters
def make_animal_sound(sound = 'Cuack')
 puts sound
end
make_animal_sound('Mooo') # Mooo
make_animal_sound # Cuack

# It's possible to include defaults for multiple arguments:

def make_animal_sound(sound = 'Cuack', volume = 11)
 play_sound(sound, volume)
end
make_animal_sound('Mooo') # Spinal Tap cow

# However, it's not possible to supply the second without also supplying the first. Instead of using positional
# parameters, try keyword parameters:
def make_animal_sound(sound: 'Cuack', volume: 11)
 play_sound(sound, volume)
end
make_animal_sound(volume: 1) # Duck whisper

# Or a hash parameter that stores options:
def make_animal_sound(options = {})
 options[:sound] ||= 'Cuak'
 options[:volume] ||= 11
 play_sound(sound, volume)
end
make_animal_sound(:sound => 'Mooo')

# Default parameter values can be set by any ruby expression. 
# The expression will run in the context of the method, so you can even declare local variables here. 
# Note, won't get through code review. Courtesy of caius for pointing this out.
def make_animal_sound( sound = ( raise 'TUU-too-TUU-too...' ) ); p sound; end
make_animal_sound 'blaaaa' # => 'blaaaa'
make_animal_sound # => TUU-too-TUU-too... (RuntimeError)

# 4: Optional parameter(s) (splat operator)
def welcome_guests(*guests)
 guests.each { |guest| puts "Welcome #{guest}!" }
end

welcome_guests('Tom') # Welcome Tom!
welcome_guests('Rob', 'Sally', 'Lucas') 
# Welcome Rob!
# Welcome Sally!
# Welcome Lucas!

# Note that welcome_guests(['Rob', 'Sally', 'Lucas']) will output Welcome ["Rob", "Sally", "Lucas"]!

# Instead, if you have a list, you can do welcome_guests(*['Rob', 'Sally', 'Lucas']) and that will work as
welcome_guests('Rob', 'Sally', 'Lucas').


# 5: Required default optional parameter mix
def my_mix(name,valid=true, *opt)
    puts name
    puts valid
    puts opt
end

# Call as follows:
my_mix('me')
# 'me'
# true
# []

my_mix('me', false)
# 'me'
# false
# []

my_mix('me', true, 5, 7)
# 'me'
# true
# [5,7]


# 6: Use a function as a block
# Many functions in Ruby accept a block as an argument. E.g.:
[0, 1, 2].map {|i| i + 1}
# => [1, 2, 3]


# If you already have a function that does what you want, you can turn it into a block using &method(:fn):
def inc(num)
 num + 1
end

# [0, 1, 2].map(&method(:inc)) or
[0, 1, 2].map(&method(:inc))
# => [1, 2, 3]


# 7: Single required parameter
def say_hello_to(name)
 puts "Hello #{name}"
end
say_hello_to('Charles') # Hello Charles


# 8: Tuple Arguments
# A method can take an array parameter and destructure it immediately into named local variables. 
# Found on Mathias Meyer's blog.
def feed( amount, (animal, food) )
 p "#{amount} #{animal}s chew some #{food}"
end

feed 3, [ 'rabbit', 'grass' ] # => "3 rabbits chew some grass"


# 9: Capturing undeclared keyword arguments (double splat)
# The ** operator works similarly to the * operator but it applies to keyword parameters.
def options(required_key:, optional_key: nil, **other_options)
 other_options
end
options(required_key: 'Done!', foo: 'Foo!', bar: 'Bar!')
#> { :foo => "Foo!", :bar => "Bar!" }

# In the above example, if the **other_options is not used, an ArgumentError: unknown keyword: foo, bar error would be raised.
def without_double_splat(required_key:, optional_key: nil)
 # do nothing
end
without_double_splat(required_key: 'Done!', foo: 'Foo!', bar: 'Bar!')
#> ArgumentError: unknown keywords: foo, bar

# This is handy when you have a hash of options that you want to pass to a method and you do not want to filter the keys.
def options(required_key:, optional_key: nil, **other_options)
 other_options
end
my_hash = { required_key: true, foo: 'Foo!', bar: 'Bar!' }
options(my_hash)
#> { :foo => "Foo!", :bar => "Bar!" }

# It is also possible to unpack a hash using the ** operator. 
# This allows you to supply keyword directly to a method in addition to values from other hashes:
my_hash = { foo: 'Foo!', bar: 'Bar!' }
options(required_key: true, **my_hash)
#> { :foo => "Foo!", :bar => "Bar!" }

# 10: Multiple required parameters
def greet(greeting, name)
 puts "#{greeting} #{name}"
end
greet('Hi', 'Sophie') # Hi Sophie

# 11: Method Definitions are Expressions
# Defining a method in Ruby 2.x returns a symbol representing the name:
class Example
 puts def hello
 end
end
#=> :hello

# This allows for interesting metaprogramming techniques.
# For instance, methods can be wrapped by other methods:
class Class
 def logged(name)
    original_method = instance_method(name)
    define_method(name) do |*args|
        puts "Calling #{name} with #{args.inspect}."
        original_method.bind(self).call(*args)
        puts "Completed #{name}."
    end
 end
end

class Meal
 def initialize
    @food = []
 end
 logged def add(item)
    @food << item
 end
end

meal = Meal.new
meal.add 'Coffee'
# Calling add with ["Coffee"].
# Completed add.

## Keyword Arguments

# 1: Using arbitrary keyword arguments with splat operator
# You can define a method to accept an arbitrary number of keyword arguments using the double splat (**) operator:
def say(**args)
 puts args
end
say foo: "1", bar: "2"
# {:foo=>"1", :bar=>"2"}

# The arguments are captured in a Hash. You can manipulate the Hash, for example to extract the desired arguments.

def say(**args)
 puts args[:message] || "Message not found"
end
say foo: "1", bar: "2", message: "Hello World"
# Hello World
say foo: "1", bar: "2"
# Message not found

# Using a the splat operator with keyword arguments will prevent keyword argument validation, the method will
# never raise an ArgumentError in case of unknown keyword.

# As for the standard splat operator, you can re-convert a Hash into keyword arguments for a method:
def say(message: nil, before: "<p>", after: "</p>")
 puts "#{before}#{message}#{after}"
end
args = { message: "Hello World", after: "</p><hr>" }
say(**args)
# <p>Hello World</p><hr>

args = { message: "Hello World", foo: "1" }
say(**args)
# => ArgumentError: unknown keyword: foo

# This is generally used when you need to manipulate incoming arguments, and pass them to an underlying method:
def inner(foo:, bar:)
 puts foo, bar
end

def outer(something, foo: nil, bar: nil, baz: nil)
 puts something
 params = {}
 params[:foo] = foo || "Default foo"
 params[:bar] = bar || "Default bar"
 inner(**params)
end

outer "Hello:", foo: "Custom foo"
# Hello:
# Custom foo
# Default bar

# 2: Using keyword arguments
# You define a keyword argument in a method by specifying the name in the method definition:
def say(message: "Hello World")
 puts message
end
say
# => "Hello World"
say message: "Today is Monday"
# => "Today is Monday"

# You can define multiple keyword arguments, the definition order is irrelevant:
def say(message: "Hello World", before: "<p>", after: "</p>")
 puts "#{before}#{message}#{after}"
end
say
# => "<p>Hello World</p>"
say message: "Today is Monday"
# => "<p>Today is Monday</p>"
say after: "</p><hr>", message: "Today is Monday"
# => "<p>Today is Monday</p><hr>"

# Keyword arguments can be mixed with positional arguments:
def say(message, before: "<p>", after: "</p>")
 puts "#{before}#{message}#{after}"
end
say "Hello World", before: "<span>", after: "</span>"
# => "<span>Hello World</span>"

# Mixing keyword argument with positional argument was a very common approach before Ruby 2.1, because it was not possible to define required keyword arguments.
# Moreover, in Ruby < 2.0, it was very common to add an Hash at the end of a method definition to use for optional
# arguments. The syntax is very similar to keyword arguments, to the point where optional arguments via Hash are
# compatible with Ruby 2 keyword arguments.
def say(message, options = {})
 before = option.fetch(:before, "<p>")
 after = option.fetch(:after, "</p>")
 puts "#{before}#{message}#{after}"
end

# The method call is syntactically equivalent to the keyword argument one
say "Hello World", before: "<span>", after: "</span>"
# => "<span>Hello World</span>"

# Note that trying to pass a not-defined keyword argument will result in an error:
def say(message: "Hello World")
 puts message
end
say foo: "Hello"
# => ArgumentError: unknown keyword: foo


# 3: Required keyword arguments
# Version ≥ 2.1
# Required keyword arguments were introduced in Ruby 2.1, as an improvement to keyword arguments.
# To define a keyword argument as required, simply declare the argument without a default value.
def say(message:)
 puts message
end

say
# => ArgumentError: missing keyword: message

say message: "Hello World"
# => "Hello World"

# You can also mix required and non-required keyword arguments:
def say(before: "<p>", message:, after: "</p>")
 puts "#{before}#{message}#{after}"
end

say
# => ArgumentError: missing keyword: message

say message: "Hello World"
# => "<p>Hello World</p>"

say message: "Hello World", before: "<span>", after: "</span>"
# => "<span>Hello World</span>"
