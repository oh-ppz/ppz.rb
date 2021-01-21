# 解析一个 .ppz 文档（可以是一个文件、字符串）

require_relative '../context/one'
require_relative '../../model/section/leaf'
require_relative '../../model/section/root'
require_relative '../../model/p/index'

class AbstractOneParser
  def initialize
    @context = ContextOne.new RootSectionModel.new
  end

  def get_model
    loop do
      line = read_line
      break unless line != nil
      handle_line line
    end
    @context.root
  end

  private
    def handle_line line
      # section
      if flag = (LeafSectionModel::REG_EXP.match line)
        flag_length = flag.to_s.length
        level = {
          2 => 1,
          6 => 3
        }[flag_length] || 2
        # 实例化 model
        target = LeafSectionModel.new line[flag_length..-1], level
        # 检查 level
        loop do
          break if @context.level < target.level
          @context.pop
        end
      # p
      else
        target = PModel.new line
      end

      # 添加到父级 model
      @context.head.append target

      # 推入上下文
      if target.is_a? AbstractWrapperModel
        @context.append target 
      end
    end
end