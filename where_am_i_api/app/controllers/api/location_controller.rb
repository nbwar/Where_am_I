module Api
  class LocationController < ApplicationController
    def determine_distance
      render :json => {blah: 'blah'}
    end
  end
end
