require_relative './model'

class AbstractWrapperModel < AbstractModel
  def initialize
    @children = []
  end
  
  # 把 el 加入到 children
  def append el
    if el.respond_to? :on_append
      el.on_append
    end
    @children.push el
  end

  def to_html
    @children
      .map { |child| child.to_html }
      .join
  end
end