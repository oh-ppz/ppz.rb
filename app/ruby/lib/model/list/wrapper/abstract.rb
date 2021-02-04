class PPZ::AbstractListWrapperModel < PPZ::AbstractWrapperModel
  attr_reader :level
  
  def initialize level
    super()
    @level = level
  end

  def to_html
    "<#{self.class::TAG_NAME}>#{super}</#{self.class::TAG_NAME}>"
  end
end