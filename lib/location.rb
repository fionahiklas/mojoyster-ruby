require 'logger'


module Location

  DEFAULT_ZONE = 0
  BUS_ZONE = -1

  def hasEntranceAndExit()
    throw 'Method hasEntranceAndExit not implemented'
  end

  def defaultZone()
    (hasEntranceAndExit()) ? DEFAULT_ZONE : BUS_ZONE
  end
end