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
  # Only tube stations have specific zones
  # buses are just priced according to fixed fares
  #
  def hasZones()
    throw 'Method has zones not implemented'
  end

  def defaultZone()
    (hasZones()) ? DEFAULT_ZONE : BUS_ZONE
  end

  def getZones()
    throw 'Method get zone not implemented'
  end
end