require 'test/unit'
require 'logger'
require 'farecalculator'


class TestFareCalculatorObject < Test::Unit::TestCase

  @@log = Logger.new(STDOUT)

  def setup()
    @@log.debug('Creating new fare calculator')
    @farecalculator = FareCalculator.new
  end

  def test_creation()
    assert(@farecalculator!=nil)
    assert(@farecalculator.instance_of?(FareCalculator))
  end

  def test_create_fare()
    fare = Fare.new(0, 0, 200)
    assert(fare!=nil)
  end

  def test_read_fare_details()
    fare = Fare.new(1, 1, 300)
    assert(fare.specialZone == 1)
    assert(fare.zoneDifference == 1)
    assert(fare.fareRate == 300)
  end


end
