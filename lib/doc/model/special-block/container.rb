class PPZ::SpecialContainerModel < PPZ::AbstractWrapperModel
  UpperClass = PPZ::AbstractSectionModel

  REG_EXP = /^```( (.*))?$/
  def self.from_line line
    if REG_EXP.match line
      if $2 && ($2.include? '```')
        nil
      else
        PPZ::SpecialContainerModel.new $2
      end
    else
      nil
    end
  end

  def initialize name
    @name = name
    super()
  end
  
  def to_html
    "<ol class=\"special-block-container #{@name}\">#{super}</ol>"
  end
end