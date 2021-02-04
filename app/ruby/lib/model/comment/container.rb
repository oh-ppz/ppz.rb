class PPZ::CommentContainerModel < PPZ::AbstractWrapperModel
  UpperClass = PPZ::AbstractSectionModel

  def to_html
    "<div class=\"comment\">#{super}</div>"
  end
end