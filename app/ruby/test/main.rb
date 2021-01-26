require_relative '../src/object/parser/doc/string'
require_relative '../src/func/index'

target = StringParser.new %{哈哈哈啊哈
# haha
+ 1
+ 2

+ 3
+ 4

##hahh
## haha
go
+ 1
+ 2
+33
}

model = target.get_model
html = model.to_html
Func::write_to_file 'test.html', html