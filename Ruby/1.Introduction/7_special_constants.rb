# SPECIAL CONSTANTS IN RUBY

# 1: __FILE__
# It is the relative path to the file from the current execution directory
# Assume we have this directory structure: /home/stackoverflow/script.rb
# script.rb contains:

puts __FILE__

# If you are inside /home/stackoverflow and execute the script like ruby script.rb then __FILE__ will output
# script.rb If you are inside /home then it will output stackoverflow/script.rb
# Very useful to get the path of the script in versions prior to 2.0 where __dir__ doesn't exist.
# Note __FILE__ is not equal to __dir__


# 2: __dir__
# __dir__ is not a constant but a function
# __dir__ is equal to File.dirname(File.realpath(__FILE__))
puts __dir__

# 3: $PROGRAM_NAME or $0
# Contains the name of the script being executed.
# Is the same as __FILE__ if you are executing that script

puts $PROGRAM_NAME # or $0

# 4: $$
# The process number of the Ruby running this script
puts $$

# 5: $1, $2, etc
# Contains the subpattern from the corresponding set of parentheses in the last successful pattern matched, not
# counting patterns matched in nested blocks that have been exited already, or nil if the last pattern match failed.
# These variables are all read-only.

# 6: ARGV or $*
# Command line arguments given for the script. The options for Ruby interpreter are already removed.

# 7: STDIN
# The standard input. The default value for $stdin

# 8: STDOUT
# The standard output. The default value for $stdout

# 9: STDERR
# The standard error output. The default value for $stderr

# 10: $stderr
# The current standard error output.

# 11: $stdout
# The current standard output

# 12: $stdin
# The current standard input

# 13: ENV
# The hash-like object contains current environment variables. Setting a value in ENV changes the environment for
# child processes
