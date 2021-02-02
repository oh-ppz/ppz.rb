# 解析一个 .ppz 文档（可以是一个文件、字符串）

require_relative '../common/context/doc'
require_relative '../../model/section/leaf'
require_relative '../../model/section/root'
require_relative '../../model/p/index'
require_relative '../../model/list/item/unordered'
require_relative '../../model/list/wrapper/unordered'
require_relative '../../model/special-block/container'
require_relative '../../model/special-block/item'

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
      if @context.head.is_a? SpecialContainerModel
      # special-block
        if /^``` *$/.match line
        # special-block-end
          @context.pop
          return
        else
        # special-block-item
          target = SpecialItemModel.new line
        end
      elsif target = SpecialContainerModel.from_line(line)
      # special-block-container
      elsif target = LeafSectionModel.from_line(line)
      # section
        # 检查 level
        loop do
          break if @context.level < target.level
          @context.pop
        end
      elsif target = UnorderedListItemModel.from_line(line)
      # 列表
        head = @context.head
        unless (head.is_a? UnorderedListWrapperModel) and (head.level == target.level) # 如果当前不在一个 无序列表 里
          wrapper = UnorderedListWrapperModel.new target.level # 就整一个无序列表
          loop do # 找到最近的 section 或 list
            head = @context.head
            break if (head.is_a? AbstractSectionModel) or
              ((head.is_a? AbstractListWrapperModel) and (head.level < wrapper.level))
            @context.pop
          end
          @context.head.append wrapper # 加入 wrapper
          @context.append wrapper # wrapper 入上下文栈
        end
      # p
      else
        @context.pop_to_section # 找到最近的 section
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