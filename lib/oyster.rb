require 'logger'


class Oyster

  attr_reader :balance, :startingStation

  def initialize
    @balance = 0
    @startingStation = nil
  end

end