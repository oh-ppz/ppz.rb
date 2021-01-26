require_relative '../../abstract/model.rb'

class AbstractListWrapperModel < AbstractWrapperModel
  def to_html
    "<#{self.class::TAG_NAME}>#{super}</#{self.class::TAG_NAME}>"
  end
end