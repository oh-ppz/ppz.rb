# 解析一个 .ppz 文档（可以是一个文件、字符串）

require_relative '../common/context/doc'
require_relative '../../model/section/leaf'
require_relative '../../model/section/root'
require_relative '../../model/p/index'
require_relative '../../model/list/item/unordered'
require_relative '../../model/list/wrapper/unordered'
require_relative '../../model/special-block/container'
require_relative '../../model/special-block/item'
require_relative '../../model/comment/container'
require_relative '../../model/comment/item'

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
      head = @context.head
      if head.is_a? SpecialContainerModel # 只要进入 special-block，下面的 line 都算是 special-block 的content
        # special-block
        if /^``` *$/.match line # 除非遇到 ``` （special-block 的结束符）
        # special-block-end
          @context.pop # 遇到，就跳出去
          return # 立刻结束
        elsif /\\``` *$/.match line # 但是有的 ``` （是 special-block 的内容，于是需要转义）
          line = line[1..-1]
        end
        # special-block-item
        target = SpecialItemModel.new line  
      elsif target = LeafSectionModel.from_line(line)
        # section
        # 检查 level
        loop do
          break if @context.level < target.level
          @context.pop
        end
      elsif target = UnorderedListItemModel.from_line(line)
        # 列表
        unless (head.is_a? UnorderedListWrapperModel) and (head.level == target.level) # 如果当前不在一个 无序列表 里
          wrapper = UnorderedListWrapperModel.new target.level # 就整一个无序列表
          loop do # 找到最近的 section 或 list
            break if (head.is_a? AbstractSectionModel) or
              ((head.is_a? AbstractListWrapperModel) and (head.level < wrapper.level))
            @context.pop
            head = @context.head
          end
          @context.append wrapper # wrapper 入上下文栈
        end
      elsif target = CommentItemModel.from_line(line)
        # 注释
      elsif target = SpecialContainerModel.from_line(line)
        # 特殊快
      else
        # p
        target = PModel.new line
      end

      @context.append target
    end
end