require_relative './abstract'

class LeafSectionModel < AbstractSectionModel
  REG_EXP = /^\#{1,5} /

  attr_accessor :title, :father
  attr_reader :level

  def initialize title, level
    raise TypeError unless title.is_a?(String) && level.is_a?(Integer) 
    super() # 不可以省略括号
    @title = title
    @level = level
  end

  def on_append  
    puts 'h: ' + @title
  end

  def to_html
    %{<section><h#{@level}>#{@title}</h#{@level}>#{
      super
    }</section>}
  end
end