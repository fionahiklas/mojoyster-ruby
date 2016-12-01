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
end
