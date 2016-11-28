require 'test/unit'
require 'logger'
require 'station'


class TestStationObject < Test::Unit::TestCase
  @@log = Logger.new(STDOUT)

  def setup()
    @station = Station.new
  end

  def test_creation()
    assert(@station != nil)
  end
end