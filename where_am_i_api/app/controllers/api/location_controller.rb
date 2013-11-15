module Api
  class LocationController < ApplicationController
    def determine_distance
      p '*' * 1000
      p params
      render :json => {blah: 'blah'}
    end
  end
end
