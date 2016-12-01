require 'test/unit'
require 'logger'
require 'farecalculator'


##
#
# This class extends the FareCalculator so that the internal
# state can be accessed.  While developing there are some
# fields that aren't going to be exposed to the outside world
# but it's still handy to test them :)
#
class FareCalculatorExtended < FareCalculator

  attr_reader :fareTableHash, :minimumFareForZone, :maximumFare

end


class TestFareCalculatorExtendedObject < Test::Unit::TestCase

  @@log = Logger.new(STDOUT)

  def setup()
    @@log.debug('Creating new fare calculator')
    @farecalculator = FareCalculatorExtended.new
  end

  def test_creation()
    assert(@farecalculator!=nil)
    assert(@farecalculator.instance_of?(FareCalculatorExtended), 'Instance of FareCalculatorExtended')
    assert(@farecalculator.is_a?(FareCalculator), 'Instance of FareCalculator')
  end

  def test_empty_fare_table_hash()
    assert(@farecalculator.fareTableHash)
  end

  def test_fare_table()
    fareTable = @farecalculator.fareTable(0)
    assert(fareTable!=nil)
    assert(fareTable.length ==0)
  end

  def test_maximum_fare_on_creation
    assert(@farecalculator.maximumFare == 0)
  end

  def test_minimum_fare_on_creation
    assert(@farecalculator.minimumFareForZone != nil)
    assert(@farecalculator.minimumFareForZone.instance_of?(Hash))
  end

  def test_add_fare_normal_updates_default_table()
    fareToAdd = Fare.new(0,0,200)
    @farecalculator.addFare(fareToAdd)
    fareTableHash = @farecalculator.fareTableHash
    assert(fareTableHash.length == 1)

    fareTable = fareTableHash[0]
    assert(fareTable!=nil)
    assert(fareTable.length == 1)
    assert(fareTable[0] == fareToAdd)
  end

  def test_add_one_fare_updates_maximum
    fareToAdd = Fare.new(0,0,200)
    @farecalculator.addFare(fareToAdd)
    assert(@farecalculator.maximumFare==200)
  end

  def test_add_two_fares_update_maximum
    fareToAdd_1 = Fare.new(0,0,200)
    fareToAdd_2 = Fare.new(1,0,300)
    @farecalculator.addFare(fareToAdd_1)
    @farecalculator.addFare(fareToAdd_2)

    assert(@farecalculator.maximumFare == 300)
  end

  def test_add_two_fares_update_maximum_reverse_order
    fareToAdd_1 = Fare.new(0,0,300)
    fareToAdd_2 = Fare.new(1,0,200)
    @farecalculator.addFare(fareToAdd_1)
    assert(@farecalculator.maximumFare == 300)

    @farecalculator.addFare(fareToAdd_2)
    assert(@farecalculator.maximumFare == 300)
  end

  def test_minimum_fare_for_default_zone
    fareToAdd = Fare.new(0,0,300)
    @farecalculator.addFare(fareToAdd)
    assert(@farecalculator.minimumFareForZone[0] == 300)
  end

  def test_minimum_fare_for_default_zone_three_fares
    fareToAdd_1 = Fare.new(0,0,300)
    fareToAdd_2 = Fare.new(0,0,400)
    fareToAdd_3 = Fare.new(0,0,199)

    @farecalculator.addFare(fareToAdd_1)
    @farecalculator.addFare(fareToAdd_2)
    @farecalculator.addFare(fareToAdd_3)

    assert(@farecalculator.minimumFareForZone[0] == 199)
  end

  def test_minimum_fare_for_different_zones_three_fares
    fareToAdd_1 = Fare.new(2,0,300)
    fareToAdd_2 = Fare.new(0,0,400)
    fareToAdd_3 = Fare.new(1,0,199)

    @farecalculator.addFare(fareToAdd_1)
    @farecalculator.addFare(fareToAdd_2)
    @farecalculator.addFare(fareToAdd_3)

    assert(@farecalculator.minimumFareForZone[0] == 400)
    assert(@farecalculator.minimumFareForZone[1] == 199)
    assert(@farecalculator.minimumFareForZone[2] == 300)
  end

  def test_fare_calculator_to_str
    fareToAdd_1 = Fare.new(2,0,300)
    fareToAdd_2 = Fare.new(0,0,400)
    fareToAdd_3 = Fare.new(1,0,199)

    @farecalculator.addFare(fareToAdd_1)
    @farecalculator.addFare(fareToAdd_2)
    @farecalculator.addFare(fareToAdd_3)

    string_output = @farecalculator.to_s
    @@log.debug("Output:\n#{string_output}")
  end

end
