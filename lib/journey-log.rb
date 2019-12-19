class JourneyLog
  def initialize(journey_class = Journey)
    @journey_class = journey_class
    @history = []
  end

  def in_journey?
    !!@current_journey
  end

  def current_journey
    @current_journey ||= @journey_class.new
  end

  def start(station)
    current_journey.set_entry(station)
  end

  def finish(station)
    current_journey.set_exit(station)
    current_fare = @current_journey.fare
    reset
    current_fare
  end

  def reset
    add_journey
    @current_journey = nil
  end

  def add_journey
    @history << current_journey
  end

  def history
    @history.dup
  end
end
