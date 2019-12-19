# frozen_string_literal: true

require_relative 'station'
require_relative 'journey'

class Oystercard
  attr_reader :journey, :balance

  MAX_CAP = 90
  MIN_CHARGE = 1
  PENALTY_FARE = 6

  def initialize(journey = Journey.new)
    @balance = 0
    @journey = journey
  end

  def top_up(money)
    raise "Maximum limit of #{MAX_CAP} reached" if (@balance + money) > MAX_CAP

    @balance += money
  end

  def touch_in(station)
    # touch in penalty if journey not empty
    raise 'insufficent funds' if @balance < MIN_CHARGE

    journey.set_entry(station)
  end

  def in_journey?
    journey.in_journey?
  end

  def touch_out(station)
    deduct(journey.fare)
    journey.set_exit(station)
    journey.reset_journey
  end

  private

  def deduct(fare)
    @balance -= fare
  end
end
