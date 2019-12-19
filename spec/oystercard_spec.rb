# frozen_string_literal: true

require 'oystercard'

describe Oystercard do
  let(:station) { double(:station) }

  describe '#initialize' do
    it 'has a balance of 0 by default' do
      expect(subject.balance).to eq(0)
    end
  end

  describe '#topup' do
    it { is_expected .to respond_to(:top_up).with(1).argument }

    it 'adds 5 to the balance' do
      subject.top_up(5)
      expect(subject.balance).to eq(5)
    end

    it 'raise an error if topping up over the limit' do
      subject.top_up(Oystercard::MAX_CAP)
      message = "Cannot exceed #{Oystercard::MAX_CAP} balance"
      expect { subject.top_up(1) }.to raise_error message
    end
  end

  describe '#touch_in' do
    it 'raise error if the balance is insufficient' do
      message = 'Insufficent funds. Please top up'
      expect { subject.touch_in(station) }.to raise_error message
    end

    it 'should warn about penalty fare if touching in twice' do
      subject.top_up(20)
      subject.touch_in(station)
      expect { subject.touch_in(station) }.to output.to_stdout
    end

    it 'should charge a penalty fare if touching in twice' do
      subject.top_up(20)
      subject.touch_in(station)
      expect { subject.touch_in(station) }.to change { subject.balance }.by(-6)
    end

    it { is_expected .to respond_to(:touch_in).with(1).argument }
  end

  describe '#touch_out' do
    it { is_expected .to respond_to(:touch_out).with(1).argument }

    it 'charge penalty if skipping touch in' do
      expect { subject.touch_out(station) }.to change { subject.balance }.by(-Oystercard::PENALTY_FARE)
    end
  end

  describe '#in_journey?' do
    let(:entry_station) { double(:station, zone: 1) }
    let(:exit_station) { double(:station, zone: 1) }

    before(:each) { subject.top_up(10) }

    it 'initially not in journey' do
      expect(subject).not_to be_in_journey
    end

    it 'in journey after touch in' do
      subject.touch_in(entry_station)
      expect(subject).to be_in_journey
    end

    it 'not in journey after a travel' do
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject).to_not be_in_journey
    end
  end
end
