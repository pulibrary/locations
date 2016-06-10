require_dependency "locations/application_controller"

module Locations
  class FloorsController < ApplicationController
    before_action :set_floor, only: [:show, :edit, :update, :destroy]

    # GET /floors
    def index
      @floors = Floor.all
    end

    # GET /floors/1
    def show
    end

    # GET /floors/new
    def new
      @floor = Floor.new
    end

    # GET /floors/1/edit
    def edit
    end

    # POST /floors
    def create
      @floor = Floor.new(floor_params)

      if @floor.save
        redirect_to @floor, notice: 'Floor was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /floors/1
    def update
      if @floor.update(floor_params)
        redirect_to @floor, notice: 'Floor was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /floors/1
    def destroy
      @floor.destroy
      redirect_to floors_url, notice: 'Floor was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_floor
        @floor = Floor.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def floor_params
        params.require(:floor).permit(:label, :floor_plan_uri, :starting_point, :walkable_areas)
      end
  end
end
