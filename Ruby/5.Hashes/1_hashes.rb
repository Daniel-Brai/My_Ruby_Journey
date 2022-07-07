# A Hash is a dictionary-like collection of unique keys and their values.
# Also called associative arrays, they are similar to Arrays,
# but where an Array uses integers as its index, a Hash allows you to use any object type.
# You retrieve or create a new entry in a Hash by referring to its key.

# 1: CREATING A HASH

# A hash in Ruby is an object that implements a hash table, mapping keys to values. Ruby supports a specific literal
# syntax for defining hashes using {}:
my_hash = {} # an empty hash
grades = { 'Mark' => 15, 'Jimmy' => 10, 'Jack' => 10 }

# A hash can also be created using the standard new method:
my_hash = Hash.new # any empty hash
my_hash = {} # any empty hash

# Hashes can have values of any type, including complex types like arrays, objects and other hashes:
mapping = { 'Mark' => 15, 'Jimmy' => [3,4], 'Nika' => {'a' => 3, 'b' => 5} }
mapping['Mark'] # => 15
mapping['Jimmy'] # => [3, 4]
mapping['Nika'] # => {"a"=>3, "b"=>5}

# Also keys can be of any type, including complex ones:
mapping = { 'Mark' => 15, 5 => 10, [1, 2] => 9 }
mapping['Mark'] # => 15
mapping[[1, 2]] # => 9

# Symbols are commonly used as hash keys, and Ruby 1.9 introduced a new syntax specifically to shorten this
# process. The following hashes are equivalent:

# Valid on all Ruby versions
grades = { :Mark => 15, :Jimmy => 10, :Jack => 10 }

# Valid in Ruby version 1.9+
grades = { Mark: 15, Jimmy: 10, Jack: 10 }

# The following hash (valid in all Ruby versions) is different, because all keys are strings:
grades = { "Mark" => 15, "Jimmy" => 10, "Jack" => 10 }

# While both syntax versions can be mixed, the following is discouraged.
mapping = { :length => 45, width: 10 }

# With Ruby 2.2+, there is an alternative syntax for creating a hash with symbol keys (most useful if the symbol
# contains spaces):
grades = { "Jimmy Choo": 10, "Jack Sparrow": 10 }
# => { :"Jimmy Choo" => 10, :"Jack Sparrow" => 10}

## 2: SETTTING DEFAULT VALUES

# By default, attempting to lookup the value for a key which does not exist will return nil. You can optionally specify
# some other value to return (or an action to take) when the hash is accessed with a non-existent key. Although this is
# referred to as "the default value", it need not be a single value; it could, for example, be a computed value such as
# the length of the key.
# The default value of a hash can be passed to its constructor:
h = Hash.new(0)
h[:hi] = 1
puts h[:hi] # => 1
puts h[:bye] # => 0 returns default value instead of nil

# A default can also be specified on an already constructed Hash:
# my_hash = { human: 2, animal: 1 }
# my_hash.default = 0
# my_hash[:plant] # => 0

# It is important to note that the default value is not copied each time a new key is accessed, which can lead to
# surprising results when the default value is a reference type:

# Use an empty array as the default value
authors = Hash.new([])
# Append a book title
authors[:homer] << 'The Odyssey'
# All new keys map to a reference to the same array:
authors[:plato] # => ['The Odyssey']\r

# To circumvent this problem, the Hash constructor accepts a block which is executed each time a new key is
# accessed, and the returned value is used as the default:
authors = Hash.new { [] }
# Note that we're using += instead of <<, see below
authors[:homer] += ['The Odyssey']
authors[:plato] # => []
authors # => {:homer=>["The Odyssey"]}\r

# Note that above we had to use += instead of << because the default value is not automatically assigned to the hash;
# using << would have added to the array, but authors[:homer] would have remained undefined
authors[:homer] << 'The Odyssey' # ['The Odyssey']
authors[:homer] # => []
authors # => {}


# In order to be able to assign default values on access, as well as to compute more sophisticated defaults, the
# default block is passed both the hash and the key:
authors = Hash.new { |hash, key| hash[key] = [] }
authors[:homer] << 'The Odyssey'
authors[:plato] # => []
authors # => {:homer=>["The Odyssey"], :plato=>[]}

# You can also use a default block to take an action and/or return a value dependent on the key (or some other data):
chars = Hash.new { |hash,key| key.length }
chars[:test] # => 4

# You can even create more complex hashes:
page_views = Hash.new { |hash, key| hash[key] = { count: 0, url: key } }
page_views["http://example.com"][:count] += 1
page_views # => {"http://example.com"=>{:count=>1, :url=>"http://example.com"}}

# In order to set the default to a Proc on an already-existing hash, use default_proc=:
authors = {}
authors.default_proc = proc { [] }
authors[:homer] += ['The Odyssey']
authors[:plato] # => []
authors # {:homer=>["The Odyssey"]}


# 3: ACCESSING VALUES
# Individual values of a hash are read and written using the [] and []= methods:
my_hash = { length: 4, width: 5 }
my_hash[:length] #=> => 4
my_hash[:height] = 9
my_hash #=> {:length => 4, :width => 5, :height => 9 }

# By default, accessing a key which has not been added to the hash returns nil, meaning it is always safe to attempt
# to look up a key's value:
my_hash = {}
my_hash[:age] # => nil

# Hashes can also contain keys in strings. If you try to access them normally it will just return a nil, instead you
# access them by their string keys:
my_hash = { "name" => "user" }
my_hash[:name] # => nil
my_hash["name"] # => user

# For situations where keys are expected or required to exist, hashes have a fetch method which will raise an
# exception when accessing a key that does not exist:



