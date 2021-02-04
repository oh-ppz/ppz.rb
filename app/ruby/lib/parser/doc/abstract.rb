# 解析一个 .ppz 文档（可以是一个文件、字符串）

class PPZ::AbstractDocParser
  def initialize
    @context = PPZ::DocContext.new PPZ::RootSectionModel.new
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
      if head.is_a? PPZ::SpecialContainerModel # 只要进入 special-block，下面的 line 都算是 special-block 的content
        # special-block
        if /^``` *$/.match line # 除非遇到 ``` （special-block 的结束符）
        # special-block-end
          @context.pop # 遇到，就跳出去
          return # 立刻结束
        elsif /\\``` *$/.match line # 但是有的 ``` （是 special-block 的内容，于是需要转义）
          line = line[1..-1]
        end
        # special-block-item
        target = PPZ::SpecialItemModel.new line  
      elsif target = PPZ::LeafSectionModel.from_line(line)
        # section
        loop do
          break if (head.is_a? PPZ::AbstractSectionModel) and (head.level < target.level)
          @context.pop
          head = @context.head
        end
      elsif target = PPZ::UnorderedListItemModel.from_line(line)
        # 列表
        # + 对上级 container 的操作
        # ++ 没有 container -> new
        # ++ 有，等级低 -> new
        # ++ 有，等级高 -> pop 到同等级，如果没有同等级，则 new
        # ++ 有，等级相等 -> 啥也不做
        if !(head.is_a? PPZ::UnorderedListWrapperModel) || head.level < target.level
          @context.append PPZ::UnorderedListWrapperModel.new target.level
        elsif head.level > target.level
          loop do
            @context.pop
            head = @context.head
            break if head.level <= target.level # pop 到同等级
          end
          if head.level < target.level # 如果没有同等级，则 new
            @context.append PPZ::UnorderedListWrapperModel.new target.level
          end
        end
      elsif target = PPZ::CommentItemModel.from_line(line)
        # 注释
      elsif target = PPZ::SpecialContainerModel.from_line(line)
        # 特殊快
      else
        # p
        target = PPZ::PModel.new line
      end

      @context.append target
    end
end