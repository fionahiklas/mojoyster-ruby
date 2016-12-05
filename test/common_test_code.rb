require 'location'
require 'farecalculator'


module FareTestUtils

  def setupSimpleFareTable()
    busFare1 = Fare.new(Location::BUS_ZONE, 0, 180)
    tubeFare1 = Fare.new(Location::DEFAULT_ZONE, 0, 200)
    tubeFare2 = Fare.new(1, 0, 300)
    tubeFare3 = Fare.new(0, 1, 250)
    tubeFare4 = Fare.new(1, 1, 310)

    @farecalculator.addFare(busFare1)
    @farecalculator.addFare(tubeFare1)
    @farecalculator.addFare(tubeFare2)
    @farecalculator.addFare(tubeFare3)
    @farecalculator.addFare(tubeFare4)
  end

  def setupFullFareTable()
    busFare = Fare.new(Location::BUS_ZONE, 0, 180)
    tubeFare1 = Fare.new(Location::DEFAULT_ZONE, 0, 200)
    tubeFare2 = Fare.new(Location::DEFAULT_ZONE, 1, 225)
    tubeFare3 = Fare.new(Location::DEFAULT_ZONE, 2, 320)

    tubeFare4 = Fare.new(1, 0, 250)
    tubeFare5 = Fare.new(1, 1, 300)
    tubeFare6 = Fare.new(1, 2, 320)

    @farecalculator.addFare(busFare)
    @farecalculator.addFare(tubeFare1)
    @farecalculator.addFare(tubeFare2)
    @farecalculator.addFare(tubeFare3)
    @farecalculator.addFare(tubeFare4)
    @farecalculator.addFare(tubeFare5)
    @farecalculator.addFare(tubeFare6)
  end
end