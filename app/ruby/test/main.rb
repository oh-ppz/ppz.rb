require_relative '../src/object/parser/one/string'

target = StringParser.new %{# 标题一
## 标题二
222222
### 标题2.1
2.1.2.1
haha
heihei
#### 标题2.2
##### 标题 333333
哈哈哈啊哈}

model = target.get_model
p model.to_html