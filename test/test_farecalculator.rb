require 'test/unit'
require 'logger'
require 'farecalculator'
require 'common_test_code'


class TestFareCalculatorObject < Test::Unit::TestCase

  include FareTestUtils

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

  def test_add_fare()
    fare = Fare.new(1,2,300)
    @farecalculator.addFare(fare)
    fareTable = @farecalculator.fareTable(fare.specialZone)
    assert(fareTable[fare.zoneDifference] == fare.fareRate)
  end

  def test_add_two_fares()
    fare1 = Fare.new(1,2,300)
    fare2 = Fare.new(0,0,200)
    @farecalculator.addFare(fare1)
    @farecalculator.addFare(fare2)
    fareTable = @farecalculator.fareTable(0)
    assert(fareTable[0] == 200)
  end

end
