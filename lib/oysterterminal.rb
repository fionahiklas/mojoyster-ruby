require 'logger'
require 'farecalculator'

class OysterTerminal

  @@log = Logger.new(STDOUT)

  def initialize(fareCalculator)
    @fareCalculator = fareCalculator
  end

  def topUp(oysterCard, amount)
    oysterCard.topUp(amount)
  end

  ##
  #
  # TODO: Check for minimum fare to prevent entry when not enoug hmoney
  # TODO: Check for bus tapIn and automatically tap out again
  #
  def tapIn(oysterCard, location)
    initialFare = @fareCalculator.getMaximumFare()
    @@log.debug('Tap in, initial fare: #{initialFare}')
    oysterCard.tapIn(location, initialFare)
  end

  def tapOut(oysterCard, locationOut)
    locationIn = oysterCard.startingLocation
    actualFare = @fareCalculator.getFareForJourney(locationIn, locationOut)
    fareCorrection = @fareCalculator.getMaximumFare() - actualFare
    @@log.debug('Tap out, fare correction #{fareCorrection}')
    oysterCard.tapOut(fareCorrection)
  end

end
