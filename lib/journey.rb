# frozen_string_literal: true

class Journey
  attr_reader :journey, :journey_history

  def initialize
    @journey = {}
  end

  def set_entry(station)
    @journey[:entry_station] = station
  end

  def set_exit(station)
    @journey[:exit_station] = station
  end

  def complete_journey?
    @journey.key?(:entry_station) && @journey.key?(:exit_station)
  end

  def fare
    complete_journey? ? Oystercard::MIN_CHARGE : Oystercard::PENALTY_FARE
  end
end
