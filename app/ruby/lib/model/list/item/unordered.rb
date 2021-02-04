require_relative './abstract'

class UnorderedListItemModel < AbstractListItemModel
  REG_EXP = /^(\++) (.+)/
  def self.from_line line
    return nil unless REG_EXP.match(line)
    self.new $2, $1.size
  end
end