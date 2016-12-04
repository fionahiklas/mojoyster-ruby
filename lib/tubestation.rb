require 'logger'
require 'location'

class TubeStation
  @@log = Logger.new(STDOUT)

  attr_reader :name, :zones

  include Location

  def initialize(name, zones)
    @name = name
    @zones = zones
  end

  def hasZones()
    true
  end
end
