class PPZ::FileDocParser < PPZ::AbstractDocParser
  def initialize path
    super()
    unless File.exist? path
      throw '文件不存在，可能是路径错了（需要绝对路径）：' + path
    end
    @file = File.new path
    @end = false
  end

  private def readline
    return nil if @end

    begin
      line = @file.readline
      return line[-1] == '\n'? line[0...-1] : line
    rescue EOFError => err
      @end = true
      return nil
    end
  end
end