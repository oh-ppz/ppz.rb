require_relative './abstract'

class RootSectionModel < AbstractSectionModel
  def level
    0
  end
  def dom_id
    'section'
  end
end