# frozen_string_literal: true

require_relative 'station'
require_relative 'journey'
require_relative 'journey-log'

class Oystercard
  attr_reader :journey, :balance

  MAX_CAP = 90
  MIN_CHARGE = 1
  PENALTY_FARE = 6

  def initialize(logger = JourneyLog.new)
    @balance = 0
    @logger = logger
  end

  def top_up(money)
    raise "Cannot exceed #{MAX_CAP} balance" if (@balance + money) > MAX_CAP

    @balance += money
  end

  def touch_in(station)
    if in_journey?
      deduct(PENALTY_FARE)
      @logger.reset
      puts 'Penalty fare deducted'
    end
    raise 'Insufficent funds. Please top up' if @balance < MIN_CHARGE

    @logger.start(station)
  end

  def in_journey?
    @logger.in_journey?
  end

  def touch_out(station)
    deduct(@logger.finish(station))
  end

  private

  def deduct(fare)
    @balance -= fare
  end
end
