require_relative './index'

class ContextOne < Context
  attr_reader :level

  def initialize root
    super
    @level = 0
  end

  def append target
    super
    set_level
  end

  def pop
    super
    set_level
  end

  def set_level
    if head.respond_to? :level
      @level = head.level
    end
  end
end