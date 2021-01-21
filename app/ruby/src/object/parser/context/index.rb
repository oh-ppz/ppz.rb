# 当前行，所处的上下文
# 比如 一级 section 下面的 ul 下的 第 n 个 ul

class Context
  def initialize root
    @stack = [root]
  end

  def append target
    @stack.push target
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
end