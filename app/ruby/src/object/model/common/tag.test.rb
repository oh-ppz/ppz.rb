require_relative './tag'
require_relative 'test/unit'

class TagTest < Test::Unit::TestCase
  def test_1
    assert_equal '<div></div>', AbstractModel.new.getTag
  end
  
  def test_2
    assert_equal '<div>ha i</div>', AbstractModel.new('ha i').getTag
  end

  def test_3
    assert_equal '<span>hai</span>', AbstractModel.new('hai', tagName: 'span').getTag
  end

  def test_4
    assert_equal '<span name=\'test\' tel=\'110\'>hai</span>', AbstractModel.new('hai', tagName: 'span', 
      attr: {
        name: 'test',
        tel: '110'
      }
    ).getTag
  end
end