require 'test/unit'
require 'logger'
require 'oyster'


class TestOysterObject < Test::Unit::TestCase

  @@log = Logger.new(STDOUT)


  def setup()
    @oysterInstance = Oyster.new()
  end

  def test_creation()
    assert(@oysterInstance!=nil, 'Should be non-nil')
  end

  def test_new_card_balance()
    assert(@oysterInstance.balance == 0)
  end

  def test_new_start_station()
    assert(@oysterInstance.startingStation == nil)
  end
end