require_relative '../abstract/model'

class PModel < AbstractModel
  def initialize text
    # 转义行首的加号
    pre = text[0..2]
    text = text[1..-1] if (pre == '\\+ ' or pre == '\\> ')
    # 转义 html
    text = transform_inline_element text

    @text = text
  end

  def to_html
    "<p>#{@text}</p>"
  end
end