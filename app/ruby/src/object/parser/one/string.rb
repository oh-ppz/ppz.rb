require_relative './abstract'

class StringParser < AbstractOneParser
  def initialize str
    super()
    @lines = str.split /\n/
  end

  private def read_line
    @lines.shift
  end
end