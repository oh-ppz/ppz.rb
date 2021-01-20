# 解析一个 .ppz 文档（可以是一个文件、字符串）

require './context'

class AbstractParser
  def initialize
    @context = Context.new
  end
end