class PPZ::SpecialContainerModel < PPZ::AbstractWrapperModel
  UpperClass = PPZ::AbstractSectionModel

  REG_EXP = /^```( (.*))?/
  def self.from_line line
    return nil unless REG_EXP.match(line)
    PPZ::SpecialContainerModel.new $2
  end

  def initialize name
    @name = name
    super()
  end
  
  def to_html
    "<div class=\"special-block-container #{@name}\">#{super}</div>"
  end
end