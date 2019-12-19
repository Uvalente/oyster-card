# frozen_string_literal: true

require 'journey'

describe Journey do
  let(:oystercard) { double :oystercard }
  let(:station) { double :station }

  it 'should be an empty journey before journey' do
    expect(subject.journey).to be_empty
  end

  it 'should save entrance station' do
    subject.set_entry(station)
    expect(subject.journey).to include(entry_station: station)
  end

  it 'should save exit station' do
    subject.set_exit(station)
    expect(subject.journey).to include(exit_station: station)
  end

  it 'should return minimum fare for complete journey' do
    subject.set_entry(station)
    subject.set_exit(station)
    expect(subject.fare).to eq Oystercard::MIN_CHARGE
  end

  it 'should return 6 for incomplete journey' do
    subject.set_entry(station)
    expect(subject.fare).to eq Oystercard::PENALTY_FARE
  end
end
