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
    @history << current_journey
    current_fare = @current_journey.fare
    @current_journey = nil
    current_fare
  end

  def history
    @history.dup
  end
end
