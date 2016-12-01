require 'logger'
require 'location'

class Bus

  @@log = Logger.new(STDOUT)

  attr_reader :number

  def initialize(number)
    @number = number
  end

end