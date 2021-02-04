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
        loop do
          break if (head.is_a? AbstractSectionModel) and (head.level < target.level)
          @context.pop
          head = @context.head
        end
      elsif target = UnorderedListItemModel.from_line(line)
        # 列表
        # + 对上级 container 的操作
        # ++ 没有 container -> new
        # ++ 有，等级低 -> new
        # ++ 有，等级高 -> pop 到同等级，如果没有同等级，则 new
        # ++ 有，等级相等 -> 啥也不做
        if !(head.is_a? UnorderedListWrapperModel) || head.level < target.level
          @context.append UnorderedListWrapperModel.new target.level
        elsif head.level > target.level
          loop do
            @context.pop
            head = @context.head
            break if head.level <= target.level # pop 到同等级
          end
          if head.level < target.level # 如果没有同等级，则 new
            @context.append UnorderedListWrapperModel.new target.level
          end
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