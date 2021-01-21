require_relative './abstract'

class LeafSectionModel < AbstractSectionModel
  REG_EXP = /^\#{1,5} /

  attr_accessor :level, :title, :father

  def initialize title
    super() # 不可以省略括号
    @title = title
  end

  def on_append  
    puts 'h: ' + @title
  end

  def append section
    if @level == nil
      raise '先把这个 section 加到父 section，再往里添加子 section'
    end
    super
  end
end