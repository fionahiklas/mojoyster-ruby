require 'logger'


##
#
# Common methods for locations
#
# This can be inherited (included) by specific types of
# transport location
#
module Location

  DEFAULT_ZONE = 0
  BUS_ZONE = -1

  ##
  #
  # Only tube stations have an entrance and and exit
  # buses just require one tap
  #
  def hasEntranceAndExit()
    throw 'Method hasEntranceAndExit not implemented'
  end

  def defaultZone()
    (hasEntranceAndExit()) ? DEFAULT_ZONE : BUS_ZONE
  end
end