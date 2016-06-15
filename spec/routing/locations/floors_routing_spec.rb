require "spec_helper"

describe Locations::FloorsController, type: :routing do
  describe 'routing' do

    routes { Locations::Engine.routes }

      it "routes to #index" do
        expect(get: "/floors").to route_to("locations/floors#index")
      end

      it "routes to #create" do
        expect(get: "/floors/create").to route_to("locations/floors#new")
      end

      it "routes to #show" do
        expect(get:  "/floors/1").to route_to("locations/floors#show", id: "1")
      end

      it "routes to #edit" do
        expect(get:  "/floors/1/edit").to route_to("locations/floors#edit", id: "1")
      end

      it "routes to #create" do
        expect(post: "/floors").to route_to("locations/floors#create")
      end

      it "routes to #update via PUT" do
        expect(put: "/floors/1").to route_to("locations/floors#update", id: "1")
      end

      it "routes to #update via PATCH" do
        expect(patch: "/floors/1").to route_to("locations/floors#update", id: "1")
      end

      it "routes to #destroy" do
        expect(delete: "/floors/1").to route_to("locations/floors#destroy", id: "1")
      end

  end
end
