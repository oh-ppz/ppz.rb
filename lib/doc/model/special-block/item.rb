class PPZ::SpecialItemModel < PPZ::AbstractModel
  def initialize line
    @line = line
  end
  def to_html
    "<li>#{@line}</li>"
  end
end