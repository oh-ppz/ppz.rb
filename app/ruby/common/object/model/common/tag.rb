class Tag
  def initialize name, content, attr
    @tagName = tagName
    @content = content
    @attr = attr
  end

  def to_s
    attrStr = ''
    @attr.each do |key, value|
      attrStr << " #{key}='#{value}'"
    end
    "<#{@tagName}#{attrStr}>#{@content}</#{@tagName}>"
  end
end