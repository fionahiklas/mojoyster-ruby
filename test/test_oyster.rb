require 'test/unit'
require 'logger'
require 'bus'
require 'oyster'


class TestOysterObject < Test::Unit::TestCase

  @@log = Logger.new(STDOUT)


  def setup()
    @@log.debug('Creating new instance of Oyster')
    @oysterInstance = Oyster.new()
  end

  def test_creation()
    assert(@oysterInstance!=nil, 'Should be non-nil')
  end

  def test_new_card_balance()
    assert(@oysterInstance.balance == 0)
  end

  def test_new_start_station()
    assert(@oysterInstance.startingLocation == nil)
  end

  def test_new_ending_station()
    assert(@oysterInstance.endingLocation == nil)
  end

  def test_top_up()
    @oysterInstance.topUp(3000)
    assert(@oysterInstance.balance == 3000)
  end

  def test_two_top_ups()
    @oysterInstance.topUp(2000)
    @oysterInstance.topUp(2200)
    assert(@oysterInstance.balance == 4200)
  end

  def test_negative_topup()
    caughtException = false
    begin
      @oysterInstance.topUp(-273)
    rescue
      @@log.debug('Negative top-up threw an exception')
      caughtException = true
    end
    assert(caughtException==true)
  end

  def test_tap_in
    locationIn = Bus.new(328)
    @oysterInstance.topUp(3000)

    @oysterInstance.tapIn(locationIn, 320)

    assert(@oysterInstance.startingLocation == locationIn)
    assert(@oysterInstance.balance == 2680)
  end

  def test_tap_out
    locationIn = Bus.new(328)
    @oysterInstance.topUp(2000)
    @oysterInstance.tapIn(locationIn,320)

    assert(@oysterInstance.balance == 1680)
    @oysterInstance.tapOut(120)

    assert(@oysterInstance.startingLocation == nil)
    assert(@oysterInstance.balance == 1800)
  end


end