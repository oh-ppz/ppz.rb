require_relative './model'
require_relative '../common/children-list'

class AbstractWrapperModel < AbstractModel
  def initialize
    @children = ChildrenList.new
  end
  
  # 把 el 加入到 children
  def append el
    el.on_append if el.respond_to? :on_append
    @children.append el
  end
end