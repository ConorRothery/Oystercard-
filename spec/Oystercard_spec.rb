require 'oystercard'

describe Oystercard do 
  let(:station){double :station}
  let(:exit_station){double :station}
  let(:journey){ {entry_station: station, exit_station: exit_station}}
  it 'checks whether the balance is zero' do
    expect(subject.balance).to eq (0)
  end
  
  it 'adds money' do
    subject.top_up(50)
    expect(subject.balance).to eq (50)
  end

  it 'raises an error if we top up more than £90' do 
    limit = Oystercard::LIMIT
    subject.top_up(limit)
    expect {subject.top_up 1 }.to raise_error "maximum limit of #{limit} exceeded"
  end 

  # it 'recuces the balance when we spend money using the method deduct' do 
  #   subject.top_up(50)
  #   subject.deduct(4.25) 
  #   expect(subject.balance).to eq (45.75)
  # end 

  it 'checks weather passemnger in journey' do
    expect(subject).not_to be_in_journey
  end

  it 'changes the in_journey to true after touching in' do
    subject.top_up(1)
    subject.touch_in(station)
    expect(subject).to be_in_journey
  end 

  it 'changes the in_journey back to false after touvhing out' do
    subject.top_up(1)
    subject.touch_in(station)
    subject.touch_out(exit_station)
    expect(subject).not_to be_in_journey
  end

  it 'raises error when card has less than £1' do
    expect { subject.touch_in(station) }.to raise_error 'Insufficient balance to touch in'
  end

  it 'fare is deducted after touching out' do
    subject.top_up(1)
    expect { subject.touch_out(exit_station) }.to change { subject.balance }.by(-Oystercard::MINIMUM_FARE)
  end 

  it 'remembers the entry station' do
    subject.top_up(1)
    subject.touch_in(station)
    expect(subject.entry_station).to eq(station)
  end
  
  context 'completed a journey' do
    before do 
      subject.top_up(1)
      subject.touch_in(station)
      subject.touch_out(exit_station)
    end

    it 'needs to forget the entry station when touching out' do
      expect(subject.entry_station).to eq(nil)
    end

    it 'remebers the exit station' do 
      expect(subject.exit_station).to eq(exit_station)
    end 
    
  end 

  it 'checking it has an empty list of journeys by defualt' do
    expect(subject.journeys).to be_empty
  end

  it 'checks it stores a journey' do
    subject.top_up(1)
    subject.touch_in(station)
    subject.touch_out(exit_station)
    expect(subject.journeys).to include(journey)
  end
end 


