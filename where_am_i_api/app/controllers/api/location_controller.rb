module Api
  class LocationController < ApplicationController
    def determine_distance
      # Geocoder.coordinates(params[""])

      # lat = params["latitude"]
      # lng = params["longitude"]

      render :json => {blah: 'blah'}
    end
  end
end
