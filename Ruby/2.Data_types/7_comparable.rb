# COMPARABLE

# Parameter         Details
# other             The instance to be compared to self

# 1: RECTANGLE COMPARABLE BY AREA
# Comparable is one of the most popular modules in Ruby. 
# Its purpose is to provide with convenience comparison methods.

# To use it, you have to include Comparable and define the space-ship operator (<=>):
class Rectangle
    include Comparable
    def initialize(a, b)
        @a = a
        @b = b
    end
    
    def area
        @a * @b
    end

    def <=>(other)
        area <=> other.area
    end
end

r1 = Rectangle.new(1, 1)
r2 = Rectangle.new(2, 2)
r3 = Rectangle.new(3, 3)
r2 >= r1 # => true
r2.between? r1, r3 # => true
r3.between? r1, r2 # => false
