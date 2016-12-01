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
    @maximumFare = 0
    @minimumFareForZone = Hash.new
  end

  def addFare(fareToAdd)
    @@log.debug('Adding fare')
    tableToAddTo = fareTable(fareToAdd.specialZone)
    tableToAddTo[fareToAdd.zoneDifference] = fareToAdd
    updateLimits(fareToAdd)
  end

  def fareTable(specialZone)
    @fareTableHash[specialZone] ||= Hash.new
  end

  def to_s()
    sprintf("maximumFare: %s\nminimum fares: \n%s\nfare tables:\n%s",
            @maximumFare, minimum_fare_to_str, fare_table_to_str)
  end

  private

    def updateLimits(fareToAdd)
      fareAmount = fareToAdd.fareRate
      @maximumFare = fareAmount if fareAmount > @maximumFare

      currentMinimum = @minimumFareForZone[fareToAdd.specialZone]
      newMinimum =
          (currentMinimum == nil || (currentMinimum > fareAmount) ) ? fareAmount: currentMinimum;

      @minimumFareForZone[fareToAdd.specialZone] = newMinimum
    end

    def minimum_fare_to_str()
      string_output = "Zone Minimum\n------------\n"
      @minimumFareForZone.keys.sort.each do |key|
        string_output += sprintf("%4d %6d\n", key, @minimumFareForZone[key])
      end

      string_output
    end


  def fare_table_to_str()
    string_output = "Special Zone Difference Fare Rate\n" +
                    "----------------------------------\n"
    @fareTableHash.keys.sort.each do |fareTableKey|
      fareTable = @fareTableHash[fareTableKey]

      fareTable.keys.sort.each do |fareKey|
        string_output += sprintf("%12d %10d %9d\n", fareTableKey, fareKey, fareTable[fareKey].fareRate)
      end
    end

    string_output
  end


end