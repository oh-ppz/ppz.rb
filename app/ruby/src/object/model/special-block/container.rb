require_relative '../abstract/wrapper-model'

class SpecialContainerModel < AbstractWrapperModel
  REG_EXP = /^``` (.+)/
  def self.from_line line
    return nil unless match_data = REG_EXP.match(line)
    SpecialContainerModel.new $1
  end

  def initialize name
    @name = name
    super()
  end
  
  def to_html
    "<div class=\"special-block #{@name}\">#{super}</div>"
  end
end