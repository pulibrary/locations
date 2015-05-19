require "rails_helper"

module Locations
  RSpec.describe DeliveryLocationsController, type: :routing do
    describe "routing" do

      it "routes to #index" do
        expect(:get => "/delivery_locations").to route_to("delivery_locations#index")
      end

      it "routes to #new" do
        expect(:get => "/delivery_locations/new").to route_to("delivery_locations#new")
      end

      it "routes to #show" do
        expect(:get => "/delivery_locations/1").to route_to("delivery_locations#show", :id => "1")
      end

      it "routes to #edit" do
        expect(:get => "/delivery_locations/1/edit").to route_to("delivery_locations#edit", :id => "1")
      end

      it "routes to #create" do
        expect(:post => "/delivery_locations").to route_to("delivery_locations#create")
      end

      it "routes to #update" do
        expect(:put => "/delivery_locations/1").to route_to("delivery_locations#update", :id => "1")
      end

      it "routes to #destroy" do
        expect(:delete => "/delivery_locations/1").to route_to("delivery_locations#destroy", :id => "1")
      end

    end
  end
end
