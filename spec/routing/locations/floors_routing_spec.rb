require "spec_helper"

describe Locations::FloorsController, type: :routing do
  describe 'routing' do

    routes { Locations::Engine.routes }

      it "routes to #index" do
        expect(get: "/libraries/1/floors").to route_to("locations/floors#index", library_id: "1")
      end

      it "routes to #create" do
        expect(get: "/libraries/1/floors/create").to route_to("locations/floors#new", library_id: "1")
      end

      it "routes to #show" do
        expect(get:  "/libraries/1/floors/1").to route_to("locations/floors#show", library_id: "1", id: "1")
      end

      it "routes to #edit" do
        expect(get:  "/libraries/1/floors/1/edit").to route_to("locations/floors#edit", library_id: "1", id: "1")
      end

      it "routes to #create" do
        expect(post: "/libraries/1/floors").to route_to("locations/floors#create", library_id: "1")
      end

      it "routes to #update via PUT" do
        expect(put: "/libraries/1/floors/1").to route_to("locations/floors#update", library_id: "1", id: "1")
      end

      it "routes to #update via PATCH" do
        expect(patch: "/libraries/1/floors/1").to route_to("locations/floors#update", library_id: "1", id: "1")
      end

      it "routes to #destroy" do
        expect(delete: "/libraries/1/floors/1").to route_to("locations/floors#destroy", library_id: "1", id: "1")
      end

  end
end
