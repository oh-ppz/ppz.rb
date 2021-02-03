require_relative '../abstract/model'

class CommentItemModel < AbstractModel
  ContainerClass = CommentContainerModel
  REG_EXP = /^\> (.+)/

  def initialize content
    @content = transform_inline_element content
  end
  
  def to_html
    "<div>#{@content}</div>"
  end
end