require_relative './model'
require_relative '../common/children-list'

class AbstractWrapperModel < AbstractModel
  def initialize
    @children = ChildrenList.new
  end
  
  # 把 el 加入到 children
  def append el
    @children.append el
  end
end