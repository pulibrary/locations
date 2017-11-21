require 'spec_helper'

module Locations
  describe HoursLocationsController, type: :controller do

    routes { Locations::Engine.routes }

    let(:invalid_attributes) {
      FactoryGirl.attributes_for(:hours_location, label: nil)
    }

    let(:valid_session) { {} }

    describe "GET #index" do
      render_views

      it "assigns all hours_locations as @hours_locations" do
        hours_location = FactoryGirl.create(:hours_location)
        get :index
        expect(assigns(:hours_locations)).to eq([hours_location])
      end

      it 'hours_locations is active in navbar' do
        get :index
        expect(response.body.include?('<li class="active"><a href="/locations/hours_locations')).to eq true
      end

    end

    describe "GET #show" do
      it "assigns the requested hours_location as @hours_location" do
        hours_location = FactoryGirl.create(:hours_location)
        get :show, params: { id: hours_location.code}
        expect(assigns(:hours_location)).to eq(hours_location)
      end
    end

    describe "GET #new" do
      it "assigns a new hours_location as @hours_location" do
        get :new
        expect(assigns(:hours_location)).to be_a_new(HoursLocation)
      end
    end

    describe "GET #edit" do
      it "assigns the requested hours_location as @hours_location" do
        hours_location = FactoryGirl.create(:hours_location)
        get :edit, params: { id: hours_location.code}
        expect(assigns(:hours_location)).to eq(hours_location)
      end
    end

    describe "POST #create" do
      let(:valid_params) { { params: { hours_location: FactoryGirl.attributes_for(:hours_location) } } }
      let(:invalid_params) { { params: {hours_location: invalid_attributes} } }
      context "with valid params" do
        it "creates a new hours_location" do
          expect {
            post :create, valid_params
          }.to change(HoursLocation, :count).by(1)
        end

        it "assigns a newly created hours_location as @hours_location" do
          post :create, valid_params
          expect(assigns(:hours_location)).to be_a(HoursLocation)
          expect(assigns(:hours_location)).to be_persisted
        end

        it 'passes flash notice message' do
          post :create, valid_params
          expect(flash[:notice]).to be_present
        end

        it "redirects to the created hours_location" do
          post :create, valid_params
          expect(response).to redirect_to(HoursLocation.last)
        end
      end

      context "with invalid params" do
        it "assigns a newly created but unsaved hours_location as @hours_location" do
          post :create, invalid_params
          expect(assigns(:hours_location)).to be_a_new(HoursLocation)
        end

        it 'passes a flash error message' do
          post :create, invalid_params
          expect(flash[:error]).to be_present
        end

        it "re-renders the 'new' template" do
          post :create, invalid_params
          expect(response).to render_template("new")
        end
      end
    end

    describe "PUT #update" do
      let(:hours_location) { FactoryGirl.create(:hours_location) }
      let(:updated_label) { 'Updated Label'}
      let(:new_attributes) {
        opts = { label: updated_label, code: hours_location.code }
        FactoryGirl.attributes_for(:hours_location, opts)
      }
      let(:valid_params) { { params: { id: hours_location.code, hours_location: new_attributes } } }
      let(:invalid_params) { { params: { id: hours_location.code, hours_location: invalid_attributes} } }
      context "with valid params" do
        it "updates the requested hours_location" do
          put :update, valid_params
          hours_location.reload
          expect(hours_location.label).to eq updated_label
        end

        it "assigns the requested hours_location as @hours_location" do
          put :update, valid_params
          expect(assigns(:hours_location)).to eq(hours_location)
        end

        it 'passes flash notice message' do
          put :update, valid_params
          expect(flash[:notice]).to be_present
        end

        it "redirects to the hours_location" do
          put :update, valid_params
          expect(response).to redirect_to(hours_location)
        end
      end

      context "with invalid params" do
        it "assigns the hours_location as @hours_location" do
          put :update, invalid_params
          expect(assigns(:hours_location)).to eq(hours_location)
        end

        it 'passes a flash error message' do
          put :update, invalid_params
          expect(flash[:error]).to be_present
        end

        it "re-renders the 'edit' template" do
          put :update, invalid_params
          expect(response).to render_template("edit")
        end
      end
    end

    describe "DELETE #destroy" do
      it "destroys the requested hours_location" do
        hours_location = FactoryGirl.create(:hours_location)
        expect {
          delete :destroy, params: { id: hours_location.code }
        }.to change(HoursLocation, :count).by(-1)
      end

      it 'passes flash notice message' do
        hours_location = FactoryGirl.create(:hours_location)
        delete :destroy, params: { id: hours_location.code }
        expect(flash[:notice]).to be_present
      end

      it "redirects to the hours_locations list" do
        hours_location = FactoryGirl.create(:hours_location)
        delete :destroy, params: { id: hours_location.code }
        expect(response).to redirect_to(hours_locations_path)
      end
    end

  end
end
