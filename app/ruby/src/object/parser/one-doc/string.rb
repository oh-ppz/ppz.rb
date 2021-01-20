require_relative './abstract'

class StringParser < AbstractParser
  def initialize str
    @str = str
  end

  def read_line
  end
end