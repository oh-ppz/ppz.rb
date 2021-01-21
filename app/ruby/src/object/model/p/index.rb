require_relative '../abstract/model'

class PModel < AbstractModel
  def initialize text
    @text = text
  end
  
  def on_append  
    puts ' : ' + @text
  end

  def to_html
    "<p>#{@text}</p>"
  end
end