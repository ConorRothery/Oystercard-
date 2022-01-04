class Oystercard 
  LIMIT = 90
  attr_reader :balance 

  def initialize 
    @balance = 0
  end

  def top_up(amount)
    fail 'maximum limit exceeded' if @balance + amount > 90 
    @balance += amount 
  end 

end