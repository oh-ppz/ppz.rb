require_relative '../../abstract/wrapper-model'

class AbstractListItemModel < AbstractModel
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