require 'test/unit'
require 'logger'
require 'bus'


class TestBusObject < Test::Unit::TestCase
  @@log = Logger.new(STDOUT)

  BUS_NUMBER = 328

  def setup()
    @bus = Bus.new(BUS_NUMBER)
  end

  def test_creation()
    assert(@bus != nil)
  end

  def test_bus_details()
    assert(@bus.number == BUS_NUMBER)
  end
end