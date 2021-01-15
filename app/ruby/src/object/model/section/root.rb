require_relative './abstract'

class RootSectionModel < AbstractSectionModel
  def initialize
    super
    @level = 0
  end
end