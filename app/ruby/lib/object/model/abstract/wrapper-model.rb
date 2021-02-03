require_relative './model'

class AbstractWrapperModel < AbstractModel
  def initialize
    @children = []
  end
  
  # 把 el 加入到 children
  def append el
    el.father_model = self

    left_model = @children[-1]
    if left_model
      left_model.right_model = el
      el.left_model = el
      el.index = left_model.index + 1
    else
      el.index = 1
    end
    @children.push el
  end

  def to_html
    @children
      .map { |child| child.to_html }
      .join
  end
end