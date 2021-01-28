class AbstractModel
  def self.from_line line
    return nil unless match_data = self::REG_EXP.match(line)
    self.new match_data.post_match
  end
end