require_relative 'aircraft'
require_relative 'weather'

class Airport
  attr_reader :capacity, :dock
  DEFAULT_CAPACITY = 5

  # creates an airport with a dock and an amendable capacity
  def initialize capacity=DEFAULT_CAPACITY
    @capacity = capacity
    @dock = []
  end

  # instructs the specified aircraft to land (or not)
  def land aircraft, weather=Weather.new
    can_land? aircraft, weather
    aircraft.change_status
    @dock << aircraft
    'The aircraft has landed safely to the airport'
  end

  # instructs the specified aircraft to takeoff (or not)
  def takeoff aircraft, weather=Weather.new
    can_takeoff? aircraft, weather
    aircraft.change_status
    @dock.delete aircraft
    'The aircraft has successfully taken off from the airport'
  end

  private

  # error handling for landing
  def can_land? aircraft, weather
    raise 'The aircraft is already on the ground' if aircraft.landed
    raise 'Unable to instruct landing as the airport dock is full' if full
    raise 'Unable to instruct landing due to severe weather' if weather.stormy
  end

  # error handling for takeoff
  def can_takeoff? aircraft, weather
    raise 'Unable to locate the aircraft' unless @dock.include? aircraft
    raise 'Unable to instruct landing due to severe weather' if weather.stormy
  end

  # checks if the dock is full
  def full
    @dock.count >= @capacity
  end
end