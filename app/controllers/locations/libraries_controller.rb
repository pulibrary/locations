require_dependency "locations/application_controller"

module Locations
  class LibrariesController < ApplicationController
    before_action :set_library, only: [:show, :edit, :update, :destroy]

    # GET /libraries
    def index
      @libraries = Library.all
    end

    # GET /libraries/1
    def show
    end

    # GET /libraries/new
    def new
      @library = Library.new
      @library.floors.build
    end

    # GET /libraries/1/edit
    def edit
      @library.floors.build
    end

    # POST /libraries
    def create
      @library = Library.new(library_params)

      if @library.save
        redirect_to @library, notice: 'Library was successfully created.'
      else
        flash.now[:error] = @library.errors.full_messages
        render :new
      end
    end

    # PATCH/PUT /libraries/1
    def update
      if @library.update(library_params)
        redirect_to @library, notice: 'Library was successfully updated.'
      else
        flash.now[:error] = @library.errors.full_messages
        render :edit
      end
    end

    # DELETE /libraries/1
    def destroy
      @library.destroy
      redirect_to libraries_url, notice: 'Library was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_library
        @library = Library.friendly.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def library_params
        params.require(:library).permit(:label, :code, locations_floor_ids: [], floors_attributes: [ :id, :label, :_destroy])
      end
  end
end
