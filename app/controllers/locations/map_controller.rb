require_dependency "locations/application_controller"

module Locations
  class MapController < ApplicationController

    def index
        @map = Map.new(id: map_params[:id],loc: map_params[:loc])

        if @map.valid?
          unless @map.on_reserve?
            redirect_to @map.url
          end
        else
          render plain: "Invalid parameters.", status: 400
        end

    end

    # Only allow a trusted parameter "white list" through.
    def map_params
      params.permit(:id, :loc)
    end

  end
end
