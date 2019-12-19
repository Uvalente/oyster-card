# frozen_string_literal: true

require 'journey-log'

describe JourneyLog do
  let(:station) { double(:station) }
  let(:journey) { double(:journey) }

  subject { described_class.new(journey) }

  describe '#history' do
    it 'should return a copy of history' do
      allow(journey).to receive(:new) { journey }
      allow(journey).to receive(:set_exit) { station }
      allow(journey).to receive(:fare)
      subject.finish(station)
      expect(subject.history).to eq([journey])
    end
  end
end
