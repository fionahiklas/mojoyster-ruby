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

  def initialize
    @fareTableHash = Hash.new
  end

  def addFare(fareToAdd)
    @@log.debug('Adding fare')
    tableToAddTo = fareTable(fareToAdd.specialZone)
    tableToAddTo[fareToAdd.zoneDifference] = fareToAdd
  end

  def fareTable(specialZone)
    @fareTableHash[specialZone] ||= Hash.new
  end
end