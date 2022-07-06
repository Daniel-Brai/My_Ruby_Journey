# SYMBOLS

# 1: CREATING A SYMBOL
# The most common way to create a Symbol object is by prefixing the string identifier with a colon:
:a_symbol # => :a_symbol
:a_symbol.class # => Symbol

# Here are some alternative ways to define a Symbol, in combination with a String literal:
:"a_symbol"
"a_symbol".to_sym

# Symbols also have a %s sequence that supports arbitrary delimiters similar to how %q and %Q work for strings:
%s(a_symbol)
%s{a_symbol}

# The %s is particularly useful to create a symbol from an input that contains white space:
%s{a symbol} # => :"a symbol"

# While some interesting symbols (:/, :[], :^, etc.) can be created with certain string identifiers, note that symbols
# cannot be created using a numeric identifier:
:1 # => syntax error, unexpected tINTEGER, ...
:0.3 # => syntax error, unexpected tFLOAT, ...

# Symbols may end with a single ? or ! without needing to use a string literal as the symbol's identifier:
:hello? # :"hello?" is not necessary.
:world! # :"world!" is not necessary.

# Note that all of these different methods of creating symbols will return the same object:
:symbol.object_id == "symbol".to_sym.object_id
:symbol.object_id == %s{symbol}.object_id

# Since Ruby 2.0 there is a shortcut for creating an array of symbols from words:
%i(numerator denominator) == [:numerator, :denominator]

# 2: CONVERTING A STRING TO SYMBOL
# Given a String:
s = "something"
# there are several ways to convert it to a Symbol:
s.to_sym
# => :something

:"#{s}"
# => :something

# 3: CONVERTING A SYMBOL TO STRING
# Given a Symbol:
s = :something

# The simplest way to convert it to a String is by using the Symbol#to_s method:
s.to_s
# => "something"

# Another way to do it is by using the Symbol#id2name method which is an alias for the Symbol#to_s method.
#  But it's a method that is unique to the Symbol class:
s.id2name
# => "something"
