require_relative '../../abstract/wrapper-model'

class AbstractListItemModel < AbstractModel
  def initialize text
    @text = transform_inline_element text
  end
  
  def on_append
    puts '+: ' + @text
  end

  def to_html
    "<li>#{@text}</li>"
  end
end