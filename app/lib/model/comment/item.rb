class PPZ::CommentItemModel < PPZ::AbstractModel
  ContainerClass = PPZ::CommentContainerModel
  REG_EXP = /^\> (.+)/

  def initialize content
    @content = transform_inline_element content
  end
  
  def to_html
    "<div class=\"comment-item\">#{@content}</div>"
  end
end