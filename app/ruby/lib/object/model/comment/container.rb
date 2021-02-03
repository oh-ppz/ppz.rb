require_relative '../abstract/model.rb'

class CommentContainerModel < AbstractWrapperModel
  UpperClass = AbstractSectionModel

  def to_html
    "<div class=\"comment\">#{super}</div>"
  end
end