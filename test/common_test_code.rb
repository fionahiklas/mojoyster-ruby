
module FareTestUtils

  def setupSimpleFareTable()
    busFare1 = Fare.new(Location::BUS_ZONE, 0, 180)
    tubeFare1 = Fare.new(Location::DEFAULT_ZONE, 0, 200)
    tubeFare2 = Fare.new(1, 0, 300)
    tubeFare3 = Fare.new(0, 1, 250)

    @farecalculator.addFare(busFare1)
    @farecalculator.addFare(tubeFare1)
    @farecalculator.addFare(tubeFare2)
    @farecalculator.addFare(tubeFare3)
  end

end