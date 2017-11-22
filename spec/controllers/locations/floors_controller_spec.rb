require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

module Locations
    describe FloorsController, type: :controller do

    routes { Locations::Engine.routes }

    # This should return the minimal set of attributes required to create a valid
    # Floor. As you add validations to Floor, be sure to
    # adjust the attributes here as well.

    let(:valid_attributes) {
      attrs = FactoryGirl.attributes_for(:floor)
      library = FactoryGirl.create(:library)
      attrs[:locations_library_id] = library.id
      attrs
    }

    let(:invalid_attributes) {
      FactoryGirl.attributes_for(:floor, label: nil)
    }

    # This should return the minimal set of values that should be in the session
    # in order to pass any filters (e.g. authentication) defined in
    # FloorsController. Be sure to keep this updated too.
    let(:valid_session) { {} }

    describe "GET #index" do
      render_views

      it "assigns all floors as @floors" do
        floor = Floor.create! valid_attributes
        get :index, params: {:library_id => floor.locations_library_id, :id => floor.to_param}
        expect(assigns(:floors)).to eq([floor])
      end

    end

    describe "GET #show" do
      it "assigns the requested floor as @floor" do
        floor = Floor.create! valid_attributes
        get :show, params: {:library_id => floor.locations_library_id, :id => floor.to_param}
        expect(assigns(:floor)).to eq(floor)
      end
    end

    describe "GET #new" do
      it "assigns a new floor as @floor" do
        floor = Floor.create! valid_attributes
        get :new, params: {:library_id => floor.locations_library_id, :id => floor.to_param}
        expect(assigns(:floor)).to be_a_new(Floor)
      end
    end

    describe "GET #edit" do
      it "assigns the requested floor as @floor" do
        floor = Floor.create! valid_attributes
        get :edit, params: {:library_id => floor.locations_library_id, :id => floor.to_param}
        expect(assigns(:floor)).to eq(floor)
      end
    end

    describe "POST #create" do

      context "with valid params" do
        it "creates a new Floor" do
          expect {
            post :create, params: {:library_id => valid_attributes[:locations_library_id], :floor => valid_attributes}
          }.to change(Floor, :count).by(1)
        end

        it "assigns a newly created floor as @floor" do
          post :create, params: {:library_id => valid_attributes[:locations_library_id], :floor => valid_attributes}
          expect(assigns(:floor)).to be_a(Floor)
          expect(assigns(:floor)).to be_persisted
        end

        it "redirects to the created floor" do
          post :create, params: {:library_id => valid_attributes[:locations_library_id], :floor => valid_attributes}
          expect(response).to redirect_to(library_floor_path(valid_attributes[:locations_library_id], Floor.last))
        end
      end

      context "with invalid params" do
        it "assigns a newly created but unsaved floor as @floor" do
          post :create, params: {:library_id => valid_attributes[:locations_library_id], :floor => invalid_attributes}
          expect(assigns(:floor)).to be_a_new(Floor)
        end

        it "re-renders the 'new' template" do
          post :create, params: {:library_id => valid_attributes[:locations_library_id], :floor => invalid_attributes}
          expect(response).to render_template("new")
        end
      end
    end

    describe "PUT #update" do

      context "with valid params" do
        let(:new_attributes) {
          attrs = FactoryGirl.attributes_for(:floor)
          library = FactoryGirl.create(:library)
          attrs[:locations_library_id] = library.id
          attrs
        }

        it "updates the requested floor" do
          floor = Floor.create! valid_attributes
          put :update, params: {:library_id => new_attributes[:locations_library_id], :id => floor.to_param, :floor => new_attributes}
          floor.reload
        end

        it "assigns the requested floor as @floor" do
          floor = Floor.create! valid_attributes
          put :update, params: {:library_id => valid_attributes[:locations_library_id], :id => floor.to_param, :floor => valid_attributes}
          expect(assigns(:floor)).to eq(floor)
        end

        it "redirects to the floor" do
          floor = Floor.create! valid_attributes
          put :update, params: {:library_id => valid_attributes[:locations_library_id], :id => floor.to_param, :floor => valid_attributes}
          expect(response).to redirect_to(library_floor_path(valid_attributes[:locations_library_id], floor))
        end
      end

      context "with invalid params" do
        it "assigns the floor as @floor" do
          floor = Floor.create! valid_attributes
          put :update, params: {:library_id => valid_attributes[:locations_library_id], :id => floor.to_param, :floor => invalid_attributes}
          expect(assigns(:floor)).to eq(floor)
        end

        it "re-renders the 'edit' template" do
          floor = Floor.create! valid_attributes
          put :update, params: {:library_id => valid_attributes[:locations_library_id], :id => floor.to_param, :floor => invalid_attributes}
          expect(response).to render_template("edit")
        end
      end
    end

    describe "DELETE #destroy" do
      it "destroys the requested floor" do
        floor = Floor.create! valid_attributes
        expect {
          delete :destroy, params: {:library_id => valid_attributes[:locations_library_id], :id => floor.to_param}
        }.to change(Floor, :count).by(-1)
      end

      it "redirects to the floors list" do
        floor = Floor.create! valid_attributes
        delete :destroy, params: {:library_id => valid_attributes[:locations_library_id], :id => floor.to_param}
        expect(response).to redirect_to(library_floors_path(valid_attributes[:locations_library_id]))
      end
    end

  end
end
