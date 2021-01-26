require_relative './abstract'

class StringDocParser < AbstractDocParser
  def initialize str
    super()
    @lines = str.split /\n/
  end

  private def readline
    @lines.shift
  end
end