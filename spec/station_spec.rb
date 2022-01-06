require 'station'
describe Station do

  it 'exposes a name variable' do
    station = Station.new('Oxford Road', '1')
    expect(station.name).to eq('Oxford Road')
  end 

  it 'exsposes a zone variable' do
    station = Station.new('Oxford Road', '1')
    expect(station.zone).to eq('1')
  end
  
end 