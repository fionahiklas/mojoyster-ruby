require 'logger'

class Fare

  attr_reader :specialZone, :zoneDifference, :fareRate

  def initialize(specialZone=0, zoneDifference, fareRate)
    @specialZone = specialZone
    @zoneDifference = zoneDifference
    @fareRate = fareRate
  end

end

class FareCalculator

  @@log = Logger.new(STDOUT)




end