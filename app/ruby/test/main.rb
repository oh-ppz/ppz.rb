require_relative '../src/object/parser/one/string'

target = StringParser.new %{}

puts target.read_line
puts target.read_line
puts target.read_line
puts target.read_line
puts target.read_line
