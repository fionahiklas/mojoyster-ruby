require 'logger'
require 'location'

class Bus

  @@log = Logger.new(STDOUT)

  include Location

  attr_reader :number

  def initialize(number)
    @number = number
  end

  def hasZones()
    false
  end
end