class Func
  class << self
    def write_to_file filepath, data
      if File.exist? filepath
        throw '文件已存在'
      end
      file = File.new filepath, 'w'
      file.print data
      file.close
    end
  end

  PpzEscapeRule = [
    ['\\\\', '\\backslash', '\\'],
    ['\\*', '\\star;', '*'],
    ['\\`', '\\backquote;', '`']
  ]
  class << self
    def escape_ppz! str
      PpzEscapeRule.each do |source, escaped|
        str.gsub! source, escaped
      end
    end

    def unescape_ppz! str
      PpzEscapeRule.each do |source, escaped, target|
        str.gsub! escaped, target
      end
    end
  end

  HtmlEscapeRule = [
    ['&', '&amp;'],
    ['<', '&gt;'],
    ['>', '&lt;'],
    [' ', '&nbsp;'],
    ['"', '&quot;']
  ]
  def self.escape_html! str
    HtmlEscapeRule.each do |source, escaped|
      str.gsub! source, escaped
    end
  end
end