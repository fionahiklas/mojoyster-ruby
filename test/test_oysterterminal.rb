require 'test/unit'
require 'logger'
require 'oyster'
require 'location'
require 'bus'
require 'tubestation'
require 'farecalculator'
require 'oysterterminal'
require 'common_test_code'


class TestOysterTerminal < Test::Unit::TestCase

  @@log = Logger.new(STDOUT)

  include FareTestUtils

  def setup()
    @farecalculator = FareCalculator.new()
    setupFullFareTable()

    @@log.debug('Creating new instance of Oyster Terminal')
    @oysterTerminal = OysterTerminal.new(@farecalculator)
  end

  def test_creation()
    assert(@oysterTerminal != nil)
  end

  def test_topup_card()
    oysterCard = Oyster.new()
    @oysterTerminal.topUp(oysterCard, 2234)
    assert(oysterCard.balance == 2234)
    assert(oysterCard.startingLocation == nil)
  end

  def test_topup_card_again()
    oysterCard = Oyster.new()
    @oysterTerminal.topUp(oysterCard, 2234)
    @oysterTerminal.topUp(oysterCard,  166)
    assert(oysterCard.balance == 2400)
    assert(oysterCard.startingLocation == nil)
  end

  def test_tap_in_tube_location()
    oysterCard = Oyster.new()
    @oysterTerminal.topUp(oysterCard, 2000)

    location = TubeStation.new('Euston', [1])
    @oysterTerminal.tapIn(oysterCard, location)

    assert(oysterCard.startingLocation == location)
  end

  def test_tap_in_tube_balance()
    oysterCard = Oyster.new()
    @oysterTerminal.topUp(oysterCard, 2000)

    location = TubeStation.new('Euston', [1])
    @oysterTerminal.tapIn(oysterCard, location)

    assert(oysterCard.balance == 1680)
  end

  def test_tap_out_tube_balance()
    oysterCard = Oyster.new()
    @oysterTerminal.topUp(oysterCard, 2000)

    locationIn = TubeStation.new('Euston', [1])
    locationOut = TubeStation.new('Paddington', [1])
    @oysterTerminal.tapIn(oysterCard, locationIn)
    @oysterTerminal.tapOut(oysterCard, locationOut)

    assert(oysterCard.balance == 1750)
    assert(oysterCard.startingLocation == nil)
  end

  ##
  #
  # Full journey
  #
  # Test the full journey as follows
  #  - Tube Holborn to Earl’s Court (£2.50)
  #  - 328 bus from Earl’s Court to Chelsea (£1.80)
  #  - Tube Earl’s court to Hammersmith (£2.00)
  #
  def test_zzz_full_journey()
    oysterCard = Oyster.new()

    holburn = TubeStation.new("Holburn", [1])
    earlsCourt = TubeStation.new("Earl's Court", [1,2])
    bus328 = Bus.new(328)
    hammersmith = TubeStation.new("Hammersmith", [2])

    @oysterTerminal.topUp(oysterCard, 3000)
    @oysterTerminal.tapIn(oysterCard, holburn)
    @oysterTerminal.tapOut(oysterCard, earlsCourt)

    assert(oysterCard.balance == 2750)

    @oysterTerminal.tapIn(oysterCard, bus328)
    @oysterTerminal.tapOut(oysterCard, bus328)

    assert(oysterCard.balance == 2570)

    @oysterTerminal.tapIn(oysterCard, earlsCourt)
    @oysterTerminal.tapOut(oysterCard, hammersmith)

    assert(oysterCard.balance == 2370)

    @@log.debug("FINAL BALANCE: #{oysterCard.balance}")
  end

end

