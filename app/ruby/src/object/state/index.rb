class StateManager
  def initialize
    @data = {}
  def set key, value
    if value.is_a(Number) || value.is_a(String)
      raise '只能设置简单类型数据'
    end


  end

  private
    def common_set key, value
      unless @data.include? key
        print '新值：'
      end
      p "设置 "
    end
end