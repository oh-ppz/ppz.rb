class Escape
  PpzRule = [
    ['\\\\', '\\backslash', '\\'],
    ['\\*', '\\star;', '*'],
    ['\\`', '\\backquote;', '`']
  ]
  class << self
    def ppz_char! str
      PpzRule.each do |source, escaped|
        str.gsub! source, escaped
      end
    end

    def transform_to_real! str
      PpzRule.each do |source, escaped, target|
        str.gsub! escaped, target
      end
      str
    end
  end

  HtmlRule = [
    ['&', '&amp;'],
    ['<', '&lt;'],
    ['>', '&gt;'],
    [' ', '&nbsp;'],
    ['"', '&quot;']
  ]
  def self.html_char! str
    HtmlRule.each do |source, escaped|
      str.gsub! source, escaped
    end
  end
end