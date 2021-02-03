# 当前行，所处的上下文
# 比如 一级 section 下面的 ul 下的 第 n 个 ul

require_relative '../../../../func/util'

class AbstractContext
  def initialize root
    @stack = [root]
  end

  def append target
    # ContainerClass: 容器类，如果上级不是，就造一个
    if(Func::class_has_const? target, :ContainerClass) and (head.class != target.class::ContainerClass)
      append target.class::ContainerClass.new
    end
    # UpperClass: 上级类，如果上级不是，就出栈
    if(Func::class_has_const? target, :UpperClass) and (head.class != target.class::UpperClass)
      pop_to target.class::UpperClass
    end

    head.append target # 加入 model
    @stack.push target if target.is_a? AbstractWrapperModel # 加入 stack
  end
  
  def pop
    @stack.pop
  end

  def head
    @stack[-1]
  end

  def root
    @stack[0]
  end

  private
    def pop_to klass
      loop do
        break if head.is_a? klass
        pop
      end
    end
end