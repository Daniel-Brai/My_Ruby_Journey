# Exceptions
# 1: Creating a custom exception type

# A custom exception is any class that extends Exception or a subclass of Exception.

# In general, you should always extend StandardError or a descendant. 
# The Exception family are usually for virtual machine or system errors, rescuing them can prevent a forced interruption from working as expected.

# Defines a new custom exception called FileNotFound
class FileNotFound < StandardError
end

def read_file(path)
 File.exist?(path) || raise(FileNotFound, "File #{path} not found")
 File.read(path)
end

read_file("missing.txt") #=> raises FileNotFound.new("File `missing.txt` not found")
read_file("valid.txt") #=> reads and returns the content of the file

# It's common to name exceptions by adding the Error suffix at the end:
# ConnectionError
# DontPanicError

# However, when the error is self-explanatory, you don't need to add the Error suffix because would be redundant:
# FileNotFound vs FileNotFoundError
# DatabaseExploded vs DatabaseExplodedError

# 2: Handling multiple exceptions
# You can handle multiple errors in the same rescue declaration:

begin
 # an execution that may fail
rescue FirstError, SecondError => e
 # do something if a FirstError or SecondError occurs
end

# You can also add multiple rescue declarations:

begin
 # an execution that may fail
rescue FirstError => e
 # do something if a FirstError occurs
rescue SecondError => e
 # do something if a SecondError occurs
rescue => e
 # do something if a StandardError occurs
end

# The order of the rescue blocks is relevant: the first match is the one executed. 
# Therefore, if you put StandardError as the first condition and 
# all your exceptions inherit from StandardError, then the other rescue statements will never be executed.

begin
 # an execution that may fail
rescue => e
 # this will swallow all the errors
rescue FirstError => e
 # do something if a FirstError occurs
rescue SecondError => e
 # do something if a SecondError occurs
end

# Some blocks have implicit exception handling like def, class, and module. 
# These blocks allow you to skip the begin statement.

# def foo
#  ...
# rescue CustomError
#  ...
# ensure
#  ...
# end

# 3: Handling an exception
# Use the begin/rescue block to catch (rescue) an exception and handle it:

begin
 # an execution that may fail
rescue
 # something to execute in case of failure
end

# A rescue clause is analogous to a catch block in a curly brace language like C# or Java.
# A bare rescue like this rescues StandardError.

# Note: Take care to avoid catching Exception instead of the default StandardError. 
# The Exception class includes SystemExit and NoMemoryError and other serious exceptions that you usually don't want to catch. 

# Always consider catching StandardError (the default) instead.
# You can also specify the exception class that should be rescued:

begin
 # an excecution that may fail
rescue CustomError
 # something to execute in case of CustomError
 # or descendant
end

# This rescue clause will not catch any exception that is not a CustomError.
# You can also store the exception in a specific variable:
begin
 # an excecution that may fail
rescue CustomError => error
 # error contains the exception
 puts error.message # provide human-readable details about what went wrong.
 puts error.backtrace.inspect # return an array of strings that represent the call stack
end

# If you failed to handle an exception, you can raise it any time in a rescue block.
begin
 #here goes your code
rescue => e
 #failed to handle
 raise e
end


# If you want to retry your begin block, call retry:

begin
 #here goes your code
rescue StandardError => e
 #for some reason you want to retry you code
 retry
end

# You can be stuck in a loop if you catch an exception in every retry. 
# To avoid this, limit your retry_count to a certain number of tries.

retry_count = 0
begin
 # an excecution that may fail
rescue
 if retry_count < 5
 retry_count = retry_count + 1
 retry
 else
 #retry limit exceeds, do something else
 end

# You can also provide an else block or an ensure block. 
# An else block will be executed when the begin block
# completes without an exception thrown. An ensure block will always be executed. An ensure block is analogous to a
# finally block in a curly brace language like C# or Java.

begin
 # an execution that may fail
rescue
 # something to execute in case of failure
else
 # something to execute in case of success
ensure
 # something to always execute
end

# If you are inside a def, module or class block, there is no need to use the begin statement.
# def foo
#  ...
# rescue
#  ...
# end


# 4: Raising an exception
# To raise an exception use Kernel#raise passing the exception class and/or message:
raise StandardError # raises a StandardError.new
raise StandardError, "An error" # raises a StandardError.new("An error")

# You can also simply pass an error message. In this case, the message is wrapped into a RuntimeError:
raise "An error" # raises a RuntimeError.new("An error")

# Here's an example:
def hello(subject)
 raise ArgumentError, "`subject` is missing" if subject.to_s.empty?
 puts "Hello #{subject}"
end

hello # => ArgumentError: `subject` is missing
hello("Simone") # => "Hello Simone"


# 5: Adding information to (custom) exceptions
# It may be helpful to include additional information with an exception, 
# e.g. for logging purposes or to allow
# conditional handling when the exception is caught:
class CustomError < StandardError
 attr_reader :safe_to_retry
 def initialize(safe_to_retry = false, message = 'Something went wrong')
 @safe_to_retry = safe_to_retry
 super(message)
 end
end

# Raising the exception:
raise CustomError.new(true)

# Catching the exception and accessing the additional information provided:
begin
 # do stuff
rescue CustomError => e
 retry if e.safe_to_retry
end


## Catching Exceptions with Begin / Rescue
# 1: A Basic Error Handling Block
# Let's make a function to divide two numbers, that's very trusting about its input:
def divide(x, y)
 return x/y
end

# This will work fine for a lot of inputs:
# puts divide(10, 2)  # => 5

# But not all
puts divide(10, 0) # => ZeroDivisionError: divided by 0
puts divide(10, 'a') # => TypeError: String can't be coerced into Fixnum

# We can rewrite the function by wrapping the risky division operation in a begin... end block to check for errors,
# and use a rescue clause to output a message and return nil if there is a problem.

def divide(x, y)
 begin
 return x/y
 rescue
 puts "There was an error"
 return nil
 end
end

puts divide(10, 0) # => There was an error
puts divide(10, 'a') # => There was an error


# 2: Saving the Error
# You can save the error if you want to use it in the rescue clause
def divide(x, y)
 begin
 x/y
 rescue => e
 puts "There was a %s (%s)" % [e.class, e.message]
 puts e.backtrace
 end
end

# divide(10, 0)

# There was a ZeroDivisionError (divided by 0)
#  from (irb):10:in `/'
#  from (irb):10
#  from /Users/username/.rbenv/versions/2.3.1/bin/irb:11:in `<main>'
# > divide(10, 'a')
# There was a TypeError (String can't be coerced into Fixnum)
# /Users/username/.rbenv/versions/2.3.1/lib/ruby/2.3.0/irb/workspace.rb:87:in `eval'
# /Users/username/.rbenv/versions/2.3.1/lib/ruby/2.3.0/irb/workspace.rb:87:in `evaluate'
# /Users/username/.rbenv/versions/2.3.1/lib/ruby/2.3.0/irb/context.rb:380:in `evaluate'
# /Users/username/.rbenv/versions/2.3.1/lib/ruby/2.3.0/irb.rb:489:in `block (2 levels) in eval_input'
# /Users/username/.rbenv/versions/2.3.1/lib/ruby/2.3.0/irb.rb:623:in `signal_status'
# /Users/username/.rbenv/versions/2.3.1/lib/ruby/2.3.0/irb.rb:486:in `block in eval_input'
# /Users/username/.rbenv/versions/2.3.1/lib/ruby/2.3.0/irb/ruby-lex.rb:246:in `block (2 levels) in
# each_top_level_statement'
# /Users/username/.rbenv/versions/2.3.1/lib/ruby/2.3.0/irb/ruby-lex.rb:232:in `loop'
# /Users/username/.rbenv/versions/2.3.1/lib/ruby/2.3.0/irb/ruby-lex.rb:232:in `block in
# each_top_level_statement'
# /Users/username/.rbenv/versions/2.3.1/lib/ruby/2.3.0/irb/ruby-lex.rb:231:in `catch'
# /Users/username/.rbenv/versions/2.3.1/lib/ruby/2.3.0/irb/ruby-lex.rb:231:in
# `each_top_level_statement'
# /Users/username/.rbenv/versions/2.3.1/lib/ruby/2.3.0/irb.rb:485:in `eval_input'
# /Users/username/.rbenv/versions/2.3.1/lib/ruby/2.3.0/irb.rb:395:in `block in start'
# /Users/username/.rbenv/versions/2.3.1/lib/ruby/2.3.0/irb.rb:394:in `catch'
# /Users/username/.rbenv/versions/2.3.1/lib/ruby/2.3.0/irb.rb:394:in `start'
# /Users/username/.rbenv/versions/2.3.1/bin/irb:11:in `<main>'


# Section 58.3: Checking for Dierent Errors
# If you want to do different things based on the kind of error, use multiple rescue clauses, each with a different
# error type as an argument.
def divide(x, y)
 begin
 return x/y
 rescue ZeroDivisionError
 puts "Don't divide by zero!"
 return nil
 rescue TypeError
 puts "Division only works on numbers!"
 return nil
 end
end

divide(10, 0) # => Don't divide by zero!
divide(10, 'a') # => Division only works on numbers!

# If you want to save the error for use in the rescue block:
rescue ZeroDivisionError => e

# Use a rescue clause with no argument to catch errors of a type not specified in another rescue clause.
def divide(x, y)
 begin
 return x/y
 rescue ZeroDivisionError
 puts "Don't divide by zero!"
 return nil
 rescue TypeError
 puts "Division only works on numbers!"
 return nil
 rescue => e
 puts "Don't do that (%s)" % [e.class]
 return nil
 end
end

# divide(nil, 2) # => Don't do that (NoMethodError)

# In this case, trying to divide nil by 2 is not a ZeroDivisionError or a TypeError, so it handled by the default rescue
# clause, which prints out a message to let us know that it was a NoMethodError.

# 4: Retrying
# In a rescue clause, you can use retry to run the begin clause again, presumably after changing the circumstance
# that caused the error.
def divide(x, y)
 begin
 puts "About to divide..."
 return x/y
 rescue ZeroDivisionError
 puts "Don't divide by zero!"
 y = 1
 retry
 rescue TypeError
 puts "Division only works on numbers!"
 return nil
 rescue => e
 puts "Don't do that (%s)" % [e.class]
 return nil
 end
end

# If we pass parameters that we know will cause a TypeError, the begin clause is executed (flagged here by printing
# out "About to divide") and the error is caught as before, and nil is returned:
divide(10, 'a')

# output
# About to divide...
# Division only works on numbers!
# => nil

# But if we pass parameters that will cause a ZeroDivisionError, the begin clause is executed, the error is caught,
# the divisor changed from 0 to 1, and then retry causes the begin block to be run again (from the top), now with a
# different y. The second time around there is no error and the function returns a value.
divide(10, 0)

# output
# About to divide... # First time, 10 ÷ 0
# Don't divide by zero!
# About to divide... # Second time 10 ÷ 1
# => 10

# 5: Checking Whether No Error Was Raised
# You can use an else clause for code that will be run if no error is raised.
def divide(x, y)
 begin
 z = x/y
 rescue ZeroDivisionError
 puts "Don't divide by zero!"
 rescue TypeError
 puts "Division only works on numbers!"
 return nil
 rescue => e
 puts "Don't do that (%s)" % [e.class]
 return nil
 else
 puts "This code will run if there is no error."
 return z
 end
end


# The else clause does not run if there is an error that transfers control to one of the rescue clauses:
divide(10,0)
# output
# Don't divide by zero!
# => nil

# But if no error is raised, the else clause executes:
divide(10,2)
# output
# This code will run if there is no error.
# => 5


# Note that the else clause will not be executed if you return from the begin clause
def divide(x, y)
 begin
 z = x/y
 return z # Will keep the else clause from running!
 rescue ZeroDivisionError
 puts "Don't divide by zero!"
 else
 puts "This code will run if there is no error."
 return z
 end
end

# divide(10,2)
# => 5


# 6: Code That Should Always Run
# Use an ensure clause if there is code you always want to execute.
def divide(x, y)
 begin
 z = x/y
 return z
 rescue ZeroDivisionError
 puts "Don't divide by zero!"
 rescue TypeError
 puts "Division only works on numbers!"
 return nil
 rescue => e
 puts "Don't do that (%s)" % [e.class]
 return nil
 ensure
 puts "This code ALWAYS runs."
 end
end

# The ensure clause will be executed when there is an error:
divide(10, 0)
# output
# Don't divide by zero! # rescue clause
# This code ALWAYS runs. # ensure clause
# => nil

# And when there is no error:
# > divide(10, 2)
# This code ALWAYS runs. # ensure clause
# => 5

# The ensure clause is useful when you want to make sure.
# For instance, that files are closed.
# Note that, unlike the else clause, the ensure clause is executed before the begin or rescue clause returns a value. 
# If the ensure clause has a return that will override the return value of any other clause!
