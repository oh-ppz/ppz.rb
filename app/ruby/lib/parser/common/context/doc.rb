require_relative './abstract'

class DocContext < AbstractContext
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
end