require_relative './abstract'

class UnorderedListItemModel < AbstractListItemModel
  REG_EXP = /^\++ /
  def self.from_line line
    return nil unless match_data = REG_EXP.match(line)
    self.new match_data.post_match, (match_data.to_s.size - 1)
  end
end