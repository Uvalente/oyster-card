# frozen_string_literal: true

require 'oystercard'

describe Oystercard do
  let(:station) { double :station }

  describe '#initialize' do
    it 'has a balance of 0 by default' do
      expect(subject.balance).to eq(0)
    end
  end

  describe '#topup' do
    it { is_expected .to respond_to(:top_up).with(1).argument }

    it 'adds 5 money to the balance' do
      subject.top_up(5)
      expect(subject.balance).to eq(5)
    end

    it 'has a limit of 90' do
      max_cap = Oystercard::MAX_CAP
      subject.top_up(max_cap)
      expect { subject.top_up(Oystercard::MIN_CHARGE) }.to raise_error "Maximum limit of #{max_cap} reached"
    end
  end

  describe '#touch_in' do
    # it 'deduct a penalty fare if starts a journey without previous touch out' do

    # end

    it 'raises_error insufficient funds' do
      expect { subject.touch_in(station) }.to raise_error 'Insufficent funds'
    end

    it { is_expected .to respond_to(:touch_in).with(1).argument }
  end

  describe '#touch_out' do
    it { is_expected .to respond_to(:touch_out).with(1).argument }

    let(:entry_station) { double :station }
    let(:exit_station) { double :station }

    before do
      subject.top_up(Oystercard::MIN_CHARGE)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
    end

    it 'registers end of journey' do
      expect(subject).to_not be_in_journey
    end

    it 'deducts fare' do
      expect { subject.touch_out(station) }.to change { subject.balance }.by(-Oystercard::PENALTY_FARE)
    end

    let(:journey_history) { { entrance_station: entry_station, exit_station: exit_station } }
  end

  describe '#in_journey?' do
    it 'initially not in journey' do
      expect(subject).not_to be_in_journey
    end
  end
end
