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

  attr_reader :fareTableHash

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
end
