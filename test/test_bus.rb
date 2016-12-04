require 'test/unit'
require 'logger'
require 'location'
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

  def test_bus_has_entrance_and_exit
    assert(@bus.hasZones() == false)
  end

  def test_default_fare_table
    assert(@bus.defaultZone() == Location::BUS_ZONE)
  end

end