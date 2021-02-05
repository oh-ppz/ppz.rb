class PPZ::CommentContainerModel < PPZ::AbstractWrapperModel
  UpperClass = PPZ::AbstractSectionModel

  def to_html
    "<div class=\"comment-container\">#{super}</div>"
  end
end