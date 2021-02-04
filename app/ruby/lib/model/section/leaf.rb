class PPZ::LeafSectionModel < PPZ::AbstractSectionModel
  attr_accessor :title, :section_dom_id, :level

  def initialize title, level
    raise TypeError unless title.is_a?(String) && level.is_a?(Integer) 
    super() # 不可以省略括号
    @title = transform_inline_element title
    @level = level
  end

  REG_EXP = /^(\#{1,5}) (.+)/
  def self.from_line line
    return nil unless REG_EXP.match(line)
    
    level = {
      1 => 1, # 一个井号是 一级
      5 => 3 # 五个井号是 三级
    }[$1.size] || 2 # 其余都是 两级
    PPZ::LeafSectionModel.new $2, level
  end
  
  def get_nav_html
    return "<li><a href=\"##{section_dom_id}\">#{@title}</a><ul>#{super}</ul></li>"
  end

  def to_html
    "<section id=#{@section_dom_id}><h#{@level}>#{@title}</h#{@level}>#{super}</section>"
  end
end