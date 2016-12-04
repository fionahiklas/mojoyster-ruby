require 'logger'

##
#
# Hold information about the current balance
#
# Actually holds the information about the start and end location
# as well but really that should maybe be in a journey object
# or something else.  Leaving it here for now.
#
class Oyster

  attr_reader :balance, :startingLocation, :endingLocation

  def initialize
    @balance = 0
    @startingLocation = nil
    @endingLocation = nil
  end

  def topUp(amount_of_topup)
    raise 'Negative topup' if amount_of_topup < 0
    @balance += amount_of_topup
  end

  def tapIn(locationIn)
    @startingLocation = locationIn
  end

  def tapOut(locationOut)
    @endingLocation = locationOut
  end
end