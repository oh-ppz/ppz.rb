# 解析一个 .ppz 文档（可以是一个文件、字符串）

require_relative '../context'
require_relative '../../model/section/leaf'
require_relative '../../model/section/root'

class AbstractOneParser
  def initialize
    @context = Context.new
  end

  def get_model
    root = RootSectionModel.new

    loop do
      break unless line = read_line

      
    end
  end
end