# DATETIME
#  First yuou have import the date class
require 'date'

#  1: DATETIME FROM STRING
# DateTime.parse is a very useful method which construct a DateTime from a string, guessing its format.
p DateTime.parse('Jun, 8 2016')
# => #<DateTime: 2016-06-08T00:00:00+00:00 ((2457548j,0s,0n),+0s,2299161j)>
p DateTime.parse('201603082330')
# => #<DateTime: 2016-03-08T23:30:00+00:00 ((2457456j,84600s,0n),+0s,2299161j)>
p DateTime.parse('04-11-2016 03:50')
# => #<DateTime: 2016-11-04T03:50:00+00:00 ((2457697j,13800s,0n),+0s,2299161j)>
p DateTime.parse('04-11-2016 03:50 -0300')
# => #<DateTime: 2016-11-04T03:50:00-03:00 ((2457697j,24600s,0n),-10800s,2299161j)

#  Note: There are lots of other formats that parse recognizes.

# 2: DATETIME NEW AND NOW

DateTime.new(2001,2,3,4,5,6)
#=> #<DateTime: 2001-02-03T04:05:06+00:00 ...>
# The last element of day, hour, minute, or second can be a fractional number. 
# The fractional number’s precision is assumed at most nanosecond.

DateTime.new(2001,2,3.5)
#=> #<DateTime: 2001-02-03T12:00:00+00:00 ...>

DateTime.new(2014,10,14)
# => #<DateTime: 2014-10-14T00:00:00+00:00 ((2456945j,0s,0n),+0s,2299161j)>

# Current time:
DateTime.now
# => #<DateTime: 2022-07-03T22:01:50+01:00 ((2459764j,75710s,361491700n),+3600s,2299161j)>
# Note that it gives the current time in your timezone

# 3: ADD/SUBTRACT DAYS TO DATETIME

# a. DateTime + Fixnum (days quantity)
DateTime.new(2015,12,30,23,0) + 1
# => #<DateTime: 2015-12-31T23:00:00+00:00 ((2457388j,82800s,0n),+0s,2299161j)>

# b. DateTime + Float (days quantity)
DateTime.new(2015,12,30,23,0) + 2.5
# => #<DateTime: 2016-01-02T11:00:00+00:00 ((2457390j,39600s,0n),+0s,2299161j)>

# c. DateTime + Rational (days quantity)
DateTime.new(2015,12,30,23,0) + Rational(1,2)
# => #<DateTime: 2015-12-31T11:00:00+00:00 ((2457388j,39600s,0n),+0s,2299161j)>

# d. DateTime - Fixnum (days quantity)
DateTime.new(2015,12,30,23,0) - 1
# => #<DateTime: 2015-12-29T23:00:00+00:00 ((2457388j,82800s,0n),+0s,2299161j)>

# e. DateTime - Float (days quantity)
DateTime.new(2015,12,30,23,0) - 2.5
# => #<DateTime: 2015-12-28T11:00:00+00:00 ((2457385j,39600s,0n),+0s,2299161j)>

# f. DateTime - Rational (days quantity)
DateTime.new(2015,12,30,23,0) - Rational(1,2)
# => #<DateTime: 2015-12-30T11:00:00+00:00 ((2457387j,39600s,0n),+0s,2299161j)

# NOTE:
# An optional argument, the offset, indicates the difference between the local time and UTC. 
# For example, Rational(3,24) represents ahead of 3 hours of UTC, Rational(-5,24) represents behind of 5 hours of UTC. 
# The offset should be -1 to +1, and its precision is assumed at most second. The default value is zero (equals to UTC).

DateTime.new(2001,2,3,4,5,6,Rational(3,24))
#=> #<DateTime: 2001-02-03T04:05:06+03:00 ...>

# The offset also accepts string form:

DateTime.new(2001,2,3,4,5,6,'+03:00')
#=> #<DateTime: 2001-02-03T04:05:06+03:00 ...>