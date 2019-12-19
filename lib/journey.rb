# frozen_string_literal: true

class Journey
  attr_reader :journey, :journey_history

  def initialize
    @journey = {}
    @journey_history = []
  end

  def set_entry(station)
    @journey[:entrance_station] = station
  end

  def in_journey?
    @journey.any?
  end

  def set_exit(station)
    @journey[:exit_station] = station
    @journey_history << @journey
  end

  def complete_journey?
    @journey.key?(:entrance_station) && @journey.key?(:exit_station)
  end

  def fare
    complete_journey? ? Oystercard::MIN_CHARGE : Oystercard::PENALTY_FARE
  end

  def reset_journey
    @journey = {}
  end
end
