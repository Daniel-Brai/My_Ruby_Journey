# STRINGS

# 1. DIFFERENCE BETWEEN SINGLE-QUOTED AND DOUBLE-QUOTED STRINGS LITERALS

# The main difference is that double-quoted String literals support string interpolations and the full set of escape sequences.

# For instance, they can include arbitrary Ruby expressions via interpolation:

# Single-quoted strings don't support interpolation
puts 'Now is #{Time.now}'
# Now is #{Time.now}

# Double-quoted strings support interpolation
puts "Now is #{Time.now}"
# Now is 2016-07-21 12:43:04 +0200

# Double-quoted strings also support the entire set of escape sequences including "\n", "\t"...
puts 'Hello\nWorld'
# Hello\nWorld

puts "Hello\nWorld"
# Hello
# World

# ... while single-quoted strings support no escape sequences, baring the minimal set necessary for single-quoted
# strings to be useful: Literal single quotes and backslashes, '\'' and '\\' respectively


# 2. CREATING A STRING

# Ruby provides several ways to create a String object. The most common way is using single or double quotes to
# create a "string literal":

s1 = 'Hello'
s2 = "Hello"

# The main difference is that double-quoted string literals are a little bit more flexible as they support interpolation
# and some backslash escape sequences.

# There are also several other possible ways to create a string literal using arbitrary string delimiters. An arbitrary
# string delimiter is a % followed by a matching pair of delimiters:
%(A string)
%{A string}
%<A string>
%|A string|
%!A string!

# Finally, you can use the %q and %Q sequence, that are equivalent to ' and "":

puts %q(A string)
# => A string

puts %q(Now is #{Time.now})
# => Now is #{Time.now}

puts %Q(A string)
# => A string

puts %Q(Now is #{Time.now})
# Now is 2016-07-21 12:47:45 +0200

# %q and %Q sequences are useful when the string contains either single quotes, double quotes, or a mix of both. In
# this way, you don't need to escape the content:

# eg. %Q(<a href="/profile">User's profile<a>)

# You can use several different delimiters, as long as there is a matching pair:

# %q(A string)
# %q{A string}
# %q<A string>
# %q|A string|
# %q!A string!

# 3: CASE MANIPULATION

"string".upcase # => "STRING"
"STRING".downcase # => "string"
"String".swapcase # => "sTRING"
"string".capitalize # => "String"

# These four methods do not modify the original receiver. For example,

str = "Hello"
str.upcase # => "HELLO"
puts str # => "Hello"

# There are four similar methods that perform the same actions but modify original receiver.
"string".upcase! # => "STRING"
"STRING".downcase! # => "string"
"String".swapcase! # => "sTRING"
"string".capitalize! # => "String"

# For example,
str = "Hello"
str.upcase! # => "HELLO"
puts str # => "HELLO"

# 4: STRING CONCATENATION
# Concatenate strings with the + operator:
s1 = "Hello"
s2 = " "
s3 = "World"

puts s1 + s2 + s3
# => Hello World

s = s1 + s2 + s3
puts s
# => Hello World

# Or with the << operator:
s = 'Hello'
s << ' '
s << 'World'

puts s
# => Hello World

# Note that the << operator modifies the object on the left hand side.

# You also can multiply strings, e.g.
"wow" * 3
# => "wowwowwow"

# 5: POSITIONING STRINGS

# In Ruby, strings can be left-justified, right-justified or centered

# To left-justify string, use the ljust method. This takes in two parameters, an integer representing the number of
# characters of the new string and a string, representing the pattern to be filled.

# If the integer is greater than the length of the original string, the new string will be left-justified with the optional string parameter taking the remaining space. 
# If the string parameter is not given, the string will be padded with spaces.

str ="abcd"
str.ljust(4) # => "abcd"
str.ljust(10) # => "abcd      "
str.ljust(10, e) # => "abcdeeeeee"

# To right-justify a string, use the rjust method. This takes in two parameters, an integer representing the number of
# characters of the new string and a string, representing the pattern to be filled.
# If the integer is greater than the length of the original string, the new string will be right-justified with the optional string parameter taking the remaining space.
# If the string parameter is not given, the string will be padded with spaces.

str = "abcd"
str.rjust(4) # => "abcd"
str.rjust(10) # => "      abcd"
str.rjust(10, e) # => "eeeeeeabcd"


# To center a string, use the center method. This takes in two parameters, an integer representing the width of the
# new string and a string, which the original string will be padded with. The string will be aligned to the center.

str = "abcd"
str.center(4) # => "abcd"
str.center(10) # => "   abcd   "

# 6: SPLITTING A STRING

# String#split splits a String into an Array, based on a delimiter.
"alpha,beta".split(",")
# => ["alpha", "beta"]

# An empty String results into an empty Array:
"".split(",")
# => []

# A non-matching delimiter results in an Array containing a single item:
"alpha,beta".split(".")
# => ["alpha,beta"]

# You can also split a string using regular expressions:
"alpha, beta,gamma".split(/, ?/)
# => ["alpha", "beta", "gamma"]

# The delimiter is optional, by default a string is split on whitespace:
"alpha beta".split
# => ["alpha", "beta"]

# 7: STRING STARTS WITH

# To find if a string starts with a pattern, the start_with? method comes in handy
str = "zebras are cool"
str.start_with?("zebras") # => true

# You can also check the position of the pattern with index
str.index("zebras").zero? # => true

# 8: JOINING STRINGS

# Array#join joins an Array into a String, based on a delimiter:
["alpha", "beta"].join(",")
# => "alpha,beta"

# The delimiter is optional, and defaults to an empty String.
["alpha", "beta"].join
# => "alphabeta"

# An empty Array results in an empty String, no matter which delimiter is used.
[].join(",")
# => ""

# 9: STRING INTERPOLATION
# The double-quoted delimiter " and %Q sequence supports string interpolation using #{ruby_expression}:
puts "Now is #{Time.now}"
# Now is Now is 2016-07-21 12:47:45 +0200

puts %Q(Now is #{Time.now})
# Now is Now is 2016-07-21 12:47:45 +0200

# 10: STRING ENDS WITH
# To find if a string ends with a pattern, the end_with? method comes in handy
str = "I like pineapples"
str.end_with?("pineaaples") # => false

# 11: FORMATTED STRINGS
# Ruby can inject an array of values into a string by replacing any placeholders with the values from the supplied array.

"Hello %s, my name is %s!" % ['World', 'br3nt']
# => Hello World, my name is br3nt!

# The place holders are represented by two %s and the values are supplied by the array ['Hello', 'br3nt']. The %
# operator instructs the string to inject the values of the array.

# 12: STRING SUBSTITUTION

p "This is %s" % "foo"
# => "This is foo"

p "%s %s %s" % ["foo", "bar", "baz"]
# => "foo bar baz"

p "%{foo} == %{foo}" % {:foo => "foo" }
# => "foo == foo"

# 13: MULTI-LINE STRINGS

# The easiest way to create a multiline string is to just use multiple lines between quotation marks:
address = "Four score and seven years ago our fathers brought forth on this
continent, a new nation, conceived in Liberty, and dedicated to the
proposition that all men are created equal."

# The main problem with that technique is that if the string includes a quotation, it'll break the string syntax. To work
# around the problem, you can use a heredoc instead

# If you are writing a large block of text you may use a “here document” or “heredoc”:

expected_result = <<HEREDOC
This would contain specially formatted text.

That might span many lines
HEREDOC

# The heredoc starts on the line following <<HEREDOC and ends with the next line that starts with HEREDOC. The result includes the ending newline.

# You may use any identifier with a heredoc, but all-uppercase identifiers are typically used.

# You may indent the ending identifier if you place a “-” after <<:

expected_result = <<-INDENTED_HEREDOC
This would contain specially formatted text.

That might span many lines
  INDENTED_HEREDOC

# Note that while the closing identifier may be indented, the content is always treated as if it is flush left. 
# If you indent the content those spaces will appear in the output.

# To have indented content as well as an indented closing identifier, you can use a “squiggly” heredoc, which uses a “~” instead of a “-” after <<:

expected_result = <<~SQUIGGLY_HEREDOC
  This would contain specially formatted text.

  That might span many lines
SQUIGGLY_HEREDOC

# The indentation of the least-indented line will be removed from each line of the content. 
# Note that empty lines and lines consisting solely of literal tabs and spaces will be ignored for the purposes of determining indentation, but escaped tabs and spaces are considered non-indentation characters.

# A heredoc allows interpolation and escaped characters. You may disable interpolation and escaping by surrounding the opening identifier with single quotes:

expected_result = <<-'EXPECTED'
One plus one is #{1 + 1}
EXPECTED

p expected_result # prints: "One plus one is \#{1 + 1}\n"

# The identifier may also be surrounded with double quotes (which is the same as no quotes) or with backticks. 
# When surrounded by backticks the HEREDOC behaves like Kernel#‘:

puts <<-`HEREDOC`
cat #{__FILE__}
HEREDOC

# When surrounding with quotes, any character but that quote and newline (CR and/or LF) can be used as the identifier.

# To call a method on a heredoc place it after the opening identifier:

expected_result = <<-EXPECTED.chomp
One plus one is #{1 + 1}
EXPECTED

# You may open multiple heredocs on the same line, but this can be difficult to read:

puts (<<-ONE, <<-TWO)
content for heredoc one
ONE
content for heredoc two
TWO

# Ruby supports shell-style here documents with <<EOT, but the terminating text must start the line. 
# That screws up code indentation, so there's not a lot of reason to use that style. Unfortunately, the string will have indentations depending no how the code itself is indented.
# Ruby 2.3 solves the problem by introducing <<~ which strips out excess leading spaces:

def build_email(address)
 return (<<~EMAIL)
 TO: #{address}
 To Whom It May Concern:
 Please stop playing the bagpipes at sunrise!
 
 Regards,
 Your neighbor 
 EMAIL
end

# Percent Strings also work to create multiline strings:

%q(
HAMLET Do you see yonder cloud that's almost in shape of a camel?
POLONIUS By the mass, and 'tis like a camel, indeed.
HAMLET Methinks it is like a weasel.
POLONIUS It is backed like a weasel.
HAMLET Or like a whale?
POLONIUS Very like a whale
)

# There are a few ways to avoid interpolation and escape sequences:
# a. Single quote instead of double quote: '\n is a carriage return.'
# b. Lower case q in a percent string: %q[#{not-a-variable}]
# c. Single quote the terminal string in a heredoc:
<<-'CODE'
 puts 'Hello world!'
CODE


# 14: STRING CHARACTER REPLACEMENTS

# The tr method returns a copy of a string where the characters of the first argument are replaced by the characters of the second argument.
"string".tr('r', 'l') # => "stling"

# To replace only the first occurrence of a pattern with with another expression use the sub method
"string ring".sub('r', 'l') # => "stling ring"

# If you would like to replace all occurrences of a pattern with that expression use gsub
"string ring".gsub('r','l') # => "stling ling"

# To delete characters, pass in an empty string for the second parameter
# You can also use regular expressions in all these methods.
# It's important to note that these methods will only return a new copy of a string and won't modify the string in
# place. To do that, you need to use the tr!, sub! and gsub! methods respectively.

# 15: UNDERSTANDING THE DATA IN A STRING
# In Ruby, a string is just a sequence of bytes along with the name of an encoding (such as UTF-8, US-ASCII,
# ASCII-8BIT) that specifies how you might interpret those bytes as characters.
# Ruby strings can be used to hold text (basically a sequence of characters), in which case the UTF-8 encoding is usually used.
"abc".bytes # => [97, 98, 99]
"abc".encoding.name # => "UTF-8"

# Ruby strings can also be used to hold binary data (a sequence of bytes), in which case the ASCII-8BIT encoding is usually used.
[42].pack("i").encoding # => "ASCII-8BIT"

# It is possible for the sequence of bytes in a string to not match the encoding, resulting in errors if you try to use the string.
"\xFF \xFF".valid_encoding? # => false
"\xFF \xFF".split(' ') # ArgumentError: invalid byte sequence in UTF-8
