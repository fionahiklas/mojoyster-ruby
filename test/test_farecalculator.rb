require 'test/unit'
require 'logger'
require 'farecalculator'


class TestFareCalculatorObject < Test::Unit::TestCase

  @@log = Logger.new(STDOUT)

  def setup()
    @farecalculator = FareCalculator()
  end
end
