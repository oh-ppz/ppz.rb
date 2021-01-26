require_relative './abstract'

class FileDocParser < AbstractDocParser
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
      return @file.readline[0...-1]
    rescue EOFError => err
      @end = true
      return nil
    end
  end
end