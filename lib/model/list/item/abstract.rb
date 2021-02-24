class PPZ::AbstractListItemModel < PPZ::AbstractModel
  attr_reader :level
  
  def initialize text, level
    super()
    @text = transform_inline_element text
    @level = level
  end

  def to_html
    "<li>#{@text}</li>"
  end
end