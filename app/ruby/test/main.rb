require_relative '../src/object/parser/one/string'

target = StringParser.new %{# h1 h2
haha
heihei
## gogo aaaaaaa,\n\t..dasfkljasljfa
### gogogo}

model = target.get_model
p model
