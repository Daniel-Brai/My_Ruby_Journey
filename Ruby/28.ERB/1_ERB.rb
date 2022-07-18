# ERB
# ERB stands for Embedded Ruby, and is used to insert Ruby variables inside templates, e.g. HTML and YAML. ERB is a
# Ruby class that accepts text, and evaluates and replaces Ruby code surrounded by ERB markup.

# 1: Parsing ERB
# This example is filtered text from an IRB session.
require 'erb'
input = <<-HEREDOC
<ul>
<% (0..10).each do |i| %>
 <%# This is a comment %>
 <li><%= i %> is <%= i.even? ? 'even' : 'odd' %>.</li>
<% end %>
</ul>
HEREDOC

parser = ERB.new(input)
output = parser.result
print output

# <ul>
#  <li>0 is even.</li>
#  <li>1 is odd.</li>
#  <li>2 is even.</li>
#  <li>3 is odd.</li>
#  <li>4 is even.</li>
#  <li>5 is odd.</li>
#  <li>6 is even.</li>
#  <li>7 is odd.</li>
#  <li>9 is odd.</li>
#  <li>10 is even.</li>
# </ul>
