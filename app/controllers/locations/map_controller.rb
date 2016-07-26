require_dependency "locations/application_controller"

module Locations
  class MapController < ApplicationController

    def index
        @map = Map.new(map_params)

        if !@map.url.nil?
          redirect_to @map.url
        else
          render plain: "Invalid parameters.", status: 404
        end

    end

    # Only allow a trusted parameter "white list" through.
    def map_params
      params.permit(:id, :loc)
    end

  end
end
