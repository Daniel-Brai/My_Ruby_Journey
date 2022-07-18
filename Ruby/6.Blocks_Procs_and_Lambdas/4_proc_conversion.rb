# Converting to Proc
#Objects that respond to to_proc can be converted to procs with the & operator (which will also allow them to be
#passed as blocks).
# The class Symbol defines #to_proc so it tries to call the corresponding method on the object it receives as parameter.
p [ 'rabbit', 'grass' ].map( &:upcase ) # => ["RABBIT", "GRASS"]

# Method objects also define #to_proc.
output = method( :p )
[ 'rabbit', 'grass' ].map( &output ) # => "rabbit\ngrass"