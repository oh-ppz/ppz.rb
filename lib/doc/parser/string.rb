class PPZ::StringDocParser < PPZ::AbstractDocParser
  def initialize str
    super()
    @lines = str.split /\n/
  end

  private def readline
    @lines.shift
  end
end