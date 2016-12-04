require 'test/unit'
require 'logger'
require 'location'
require 'tubestation'


class TestTubeStationObject < Test::Unit::TestCase
  @@log = Logger.new(STDOUT)

  STATION_NAME ='Kings Cross'
  STATION_ZONES = [ 1 ]
  def setup()
    @station = TubeStation.new(STATION_NAME, STATION_ZONES)
  end

  def test_creation()
    assert(@station != nil)
  end

  def test_station_details()
    assert(@station.name == STATION_NAME)
    assert(@station.zones == STATION_ZONES)
  end

  def test_tube_has_entrance_and_exit()
    assert(@station.hasEntranceAndExit() == true)
  end

  def test_default_fare_table
    assert(@station.defaultZone() == Location::DEFAULT_ZONE)
  end
end