# 解析一个 .ppz 文档（可以是一个文件、字符串）

require_relative '../common/context/doc'
require_relative '../../model/section/leaf'
require_relative '../../model/section/root'
require_relative '../../model/p/index'
require_relative '../../model/list/item/unordered'
require_relative '../../model/list/wrapper/unordered'

class AbstractDocParser
  def initialize
    @context = DocContext.new RootSectionModel.new
  end

  def get_model
    loop do
      line = readline
      break unless line != nil
      handle_line line
    end
    @context.root
  end

  private
    def handle_line line
      if target = LeafSectionModel.from_line(line)
      # section
        # 检查 level
        loop do
          break if @context.level < target.level
          @context.pop
        end
      elsif flag = (UnorderedListItemModel::REG_EXP.match line)
      # 列表
        unless @context.head.is_a? UnorderedListWrapperModel
          loop do
            break if @context.head.is_a? AbstractSectionModel
            @context.pop
          end
          wrapper = UnorderedListWrapperModel.new
          @context.head.append wrapper
          @context.append wrapper
        end

        flag_length = flag.to_s.length
        target = UnorderedListItemModel.new line[flag_length..-1]
      # p
      else
        loop do
          break if @context.head.is_a? AbstractSectionModel
          @context.pop
        end

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