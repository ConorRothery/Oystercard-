class Oystercard  
  attr_accessor :in_journey, :balance, :entry_station, :exit_station, :journeys
    
  LIMIT = 90
  MINIMUM_FARE = 1

  def initialize 
    @balance = 0
    # @in_journey = false
    @entry_station = nil 
    @exit_station = nil 
    @journeys = Hash.new 
  end

  def top_up(amount)
    fail "maximum limit of #{LIMIT} exceeded" if @balance + amount > 90 
    @balance += amount 
  end 

  def in_journey?
    !!@entry_station
  end

  def touch_in(entry_station)
    fail 'Insufficient balance to touch in' if @balance < MINIMUM_FARE
    # @in_journey = true
    @entry_station = entry_station 
    @journeys.store(:entry_station, entry_station)
  end
  
  def touch_out(exit_station)
    deduct(MINIMUM_FARE)
    # @in_journey = false
    @entry_station = nil
    @exit_station = exit_station
    @journeys.store(:exit_station, exit_station)
  end

  
  private
  def deduct(fare)
    @balance -= fare 
  end 

end