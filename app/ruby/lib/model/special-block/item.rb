class PPZ::SpecialItemModel < PPZ::AbstractModel
  def initialize line
    @line = line
  end
  def to_html
    "<div class=\"special-block-item\">#{@line}</div>"
  end
end