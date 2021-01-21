# 解析一个 .ppz 文档（可以是一个文件、字符串）

require_relative '../context'
require_relative '../../model/section/leaf'
require_relative '../../model/section/root'
require_relative '../../model/p/index'

class AbstractOneParser
  def initialize
    @context = Context.new RootSectionModel.new
  end

  def get_model
    loop do
      line = read_line
      break unless line != nil
      handle_line line
    end
  end

  private
    def handle_line line
      if flag = (LeafSectionModel::REG_EXP.match line)
        target = LeafSectionModel.new line[flag.to_s.size..-1]
      else
        target = PModel.new line
      end

      @context.head.append target
    end
end