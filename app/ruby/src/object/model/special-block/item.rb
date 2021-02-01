require_relative '../abstract/model'

class SpecialItemModel < AbstractModel
  def initialize line
    @line = line
  end
  def to_html
    "<div>#{@line}</div>"
  end
end