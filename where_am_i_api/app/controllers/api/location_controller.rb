module Api
  class LocationController < ApplicationController
    def determine_distance
      location = Geocoder.coordinates(params["location"])
      current_location = [params["latitude"].to_f, params["longitude"].to_f]
      distance = Geocoder::Calculations.distance_between(current_location, location)
      render :json => {distance: distance}
    end
  end
end
