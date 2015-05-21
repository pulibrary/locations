require 'spec_helper'

module Locations
  describe HoldingLocationsController, type: :controller do

    routes { Locations::Engine.routes }

    let(:invalid_attributes) {
      FactoryGirl.attributes_for(:holding_location, label: nil)
    }

    let(:valid_session) { {} }

    describe "GET #index" do
      it "assigns all holding_locations as @holding_locations" do
        holding_location = FactoryGirl.create(:holding_location)
        get :index, {}, valid_session
        expect(assigns(:holding_locations)).to eq([holding_location])
      end
    end

    describe "GET #show" do
      it "assigns the requested holding_location as @holding_location" do
        holding_location = FactoryGirl.create(:holding_location)
        get :show, { id: holding_location.to_param }, valid_session
        expect(assigns(:holding_location)).to eq(holding_location)
      end
    end

    describe "GET #new" do
      it "assigns a new holding_location as @holding_location" do
        get :new, {}, valid_session
        expect(assigns(:holding_location)).to be_a_new(HoldingLocation)
      end
    end

    describe "GET #edit" do
      it "assigns the requested holding_location as @holding_location" do
        holding_location = FactoryGirl.create(:holding_location)
        get :edit, { id: holding_location.to_param }, valid_session
        expect(assigns(:holding_location)).to eq(holding_location)
      end
    end

    describe "POST #create" do
      let(:valid_attributes) {
        attrs = FactoryGirl.attributes_for(:holding_location)
        library = FactoryGirl.create(:library)
        attrs[:locations_library_id] = library.id
        attrs
      }
      context "with valid params" do
        it "creates a new HoldingLocation" do
          expect {
            post :create, { holding_location: valid_attributes }, valid_session
          }.to change(HoldingLocation, :count).by(1)
        end

        it "assigns a newly created holding_location as @holding_location" do
          post :create, { holding_location: valid_attributes }, valid_session
          expect(assigns(:holding_location)).to be_a(HoldingLocation)
          expect(assigns(:holding_location)).to be_persisted
        end

        it "redirects to the created holding_location" do
          post :create, { holding_location: valid_attributes }, valid_session
          expect(response).to redirect_to(HoldingLocation.last)
        end
      end

      context "with invalid params" do
        it "assigns a newly created but unsaved holding_location as @holding_location" do
          post :create, {holding_location: invalid_attributes }, valid_session
          expect(assigns(:holding_location)).to be_a_new(HoldingLocation)
        end

        it "re-renders the 'new' template" do
          post :create, {holding_location: invalid_attributes }, valid_session
          expect(response).to render_template("new")
        end
      end
    end

    describe "PUT #update" do
      context "with valid params" do
        let(:updated_label) { 'Updated Label'}
        let(:new_attributes) {
          FactoryGirl.attributes_for(:holding_location, label: updated_label)
        }

        it "updates the requested holding_location" do
          holding_location = FactoryGirl.create(:holding_location)
          put :update, { id: holding_location.to_param, holding_location: new_attributes}, valid_session
          holding_location.reload
          expect(holding_location.label).to eq updated_label
        end

        it "assigns the requested holding_location as @holding_location" do
          holding_location = FactoryGirl.create(:holding_location)
          put :update, { id: holding_location.to_param, holding_location: new_attributes }, valid_session
          expect(assigns(:holding_location)).to eq(holding_location)
        end

        it "redirects to the holding_location" do
          holding_location = FactoryGirl.create(:holding_location)
          put :update, { id: holding_location.to_param, holding_location: new_attributes }, valid_session
          expect(response).to redirect_to(holding_location)
        end
      end

      context "with invalid params" do
        it "assigns the holding_location as @holding_location" do
          holding_location = FactoryGirl.create(:holding_location)
          put :update, { id: holding_location.to_param, holding_location: invalid_attributes}, valid_session
          expect(assigns(:holding_location)).to eq(holding_location)
        end

        it "re-renders the 'edit' template" do
          holding_location = FactoryGirl.create(:holding_location)
          put :update, { id: holding_location.to_param, holding_location: invalid_attributes}, valid_session
          expect(response).to render_template("edit")
        end
      end
    end

    describe "DELETE #destroy" do
      it "destroys the requested holding_location" do
        holding_location = FactoryGirl.create(:holding_location)
        expect {
          delete :destroy, { id: holding_location.to_param }, valid_session
        }.to change(HoldingLocation, :count).by(-1)
      end

      it "redirects to the holding_locations list" do
        holding_location = FactoryGirl.create(:holding_location)
        delete :destroy, { id: holding_location.to_param }, valid_session
        expect(response).to redirect_to(holding_locations_path)
      end
    end

  end
end
