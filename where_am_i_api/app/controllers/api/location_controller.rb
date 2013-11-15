module Api
  class LocationController < ApplicationController
    def determine_distance
      # Geocoder.coordinates(params[""])
      lat = params["latitude"]
      lng = params["longitude"]
      location = params["location"]

      render :json => {blah: 'blah'}
    end
  end
end
