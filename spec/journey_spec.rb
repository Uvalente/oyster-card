# frozen_string_literal: true

require 'journey'

describe Journey do
  let(:oystercard) { double(:oystercard) }
  let(:station1) { double(:station, zone: 1) }
  let(:station2) { double(:station2, zone: 2) }

  it 'should be an empty journey before journey' do
    expect(subject.journey).to be_empty
  end

  it 'should save entrance station' do
    subject.set_entry(station1)
    expect(subject.journey).to include(entry_station: station1)
  end

  it 'should save exit station' do
    subject.set_exit(station1)
    expect(subject.journey).to include(exit_station: station1)
  end

  it 'should return minimum fare for same zone journey' do
    subject.set_entry(station1)
    subject.set_exit(station1)
    expect(subject.fare).to eq Oystercard::MIN_CHARGE
  end

  it 'should returns 2 for journeys between zone 1 and 2' do
    subject.set_entry(station1)
    subject.set_exit(station2)
    expect(subject.fare).to eq 2
  end

  it 'should return penalty fare for incomplete journey' do
    subject.set_entry(station1)
    expect(subject.fare).to eq Oystercard::PENALTY_FARE
  end
end
