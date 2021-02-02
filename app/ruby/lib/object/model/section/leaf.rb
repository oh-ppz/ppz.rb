require_relative './abstract'

class LeafSectionModel < AbstractSectionModel

  attr_accessor :title, :father
  attr_reader :level

  def initialize title, level
    raise TypeError unless title.is_a?(String) && level.is_a?(Integer) 
    super() # 不可以省略括号
    @title = transform_inline_element title
    @level = level
  end

  REG_EXP = /^\#{1,5} /
  def self.from_line line
    return nil unless match_data = REG_EXP.match(line)
    
    level = {
      2 => 1,
      6 => 3
    }[match_data.to_s.length] || 2
    LeafSectionModel.new match_data.post_match, level
  end

  def to_html
    %{<section><h#{@level}>#{@title}</h#{@level}>#{
      super
    }</section>}
  end
end