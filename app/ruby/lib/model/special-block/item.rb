class PPZ::SpecialItemModel < PPZ::AbstractModel
  def initialize line
    @line = line
  end
  def to_html
    "<div>#{@line}</div>"
  end
end