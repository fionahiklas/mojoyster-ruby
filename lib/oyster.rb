require 'logger'


class Oyster

  attr_reader :balance, :startingStation

  def initialize
    @balance = 0
    @startingStation = nil
  end

  def topUp(amount_of_topup)
    raise 'Negative topup' if amount_of_topup < 0
    @balance += amount_of_topup
  end
end