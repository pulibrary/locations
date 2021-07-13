# frozen_string_literal: true

require 'spec_helper'

module Locations
  describe HoldingLocationsController, type: :controller do
    routes { Locations::Engine.routes }

    let(:invalid_attributes) do
      FactoryGirl.attributes_for(:holding_location, code: nil)
    end

    let(:valid_session) { {} }

    describe 'GET #index' do
      render_views

      it 'assigns all holding_locations as @holding_locations' do
        holding_location = FactoryGirl.create(:holding_location)
        get :index
        expect(assigns(:holding_locations)).to eq([holding_location])
      end

      it 'holding_locations is active in navbar' do
        get :index
        expect(response.body.include?('<li class="active"><a href="/locations/holding_locations')).to eq true
      end
    end

    describe 'GET #show' do
      it 'assigns the requested holding_location as @holding_location' do
        holding_location = FactoryGirl.create(:holding_location)
        get :show, params: { id: holding_location.code }
        expect(assigns(:holding_location)).to eq(holding_location)
      end
    end

    describe 'GET #new' do
      it 'assigns a new holding_location as @holding_location' do
        get :new
        expect(assigns(:holding_location)).to be_a_new(HoldingLocation)
      end
    end

    describe 'GET #edit' do
      it 'assigns the requested holding_location as @holding_location' do
        holding_location = FactoryGirl.create(:holding_location)
        get :edit, params: { id: holding_location.code }
        expect(assigns(:holding_location)).to eq(holding_location)
      end
    end

    describe 'POST #create' do
      let(:valid_attributes) do
        attrs = FactoryGirl.attributes_for(:holding_location)
        library = FactoryGirl.create(:library)
        attrs[:locations_library_id] = library.id
        attrs
      end
      context 'with valid params' do
        it 'creates a new HoldingLocation' do
          expect do
            post :create, params: { holding_location: valid_attributes }
          end.to change(HoldingLocation, :count).by(1)
        end

        it 'assigns a newly created holding_location as @holding_location' do
          post :create, params: { holding_location: valid_attributes }
          expect(assigns(:holding_location)).to be_a(HoldingLocation)
          expect(assigns(:holding_location)).to be_persisted
        end

        it 'passes flash notice message' do
          post :create, params: { holding_location: valid_attributes }
          expect(flash[:notice]).to be_present
        end

        it 'redirects to the created holding_location' do
          post :create, params: { holding_location: valid_attributes }
          expect(response).to redirect_to(HoldingLocation.last)
        end
      end

      context 'with invalid params' do
        it 'assigns a newly created but unsaved holding_location as @holding_location' do
          post :create, params: { holding_location: invalid_attributes }
          expect(assigns(:holding_location)).to be_a_new(HoldingLocation)
        end

        it 'passes a flash error message' do
          post :create, params: { holding_location: invalid_attributes }
          expect(flash[:error]).to be_present
        end

        it "re-renders the 'new' template" do
          post :create, params: { holding_location: invalid_attributes }
          expect(response).to render_template('new')
        end
      end
    end

    describe 'PUT #update' do
      let(:updated_label) { 'Updated Label' }
      let(:holding_location) { FactoryGirl.create(:holding_location) }
      let(:new_attributes) do
        opts = { label: updated_label, code: holding_location.code }
        FactoryGirl.attributes_for(:holding_location, opts)
      end
      let(:valid_params) do
        { params: { id: holding_location.code, holding_location: new_attributes } }
      end
      let(:invalid_params) do
        { params: { id: holding_location.code, holding_location: invalid_attributes } }
      end
      context 'with valid params' do
        it 'updates the requested holding_location' do
          put :update, valid_params
          holding_location.reload
          expect(holding_location.label).to eq updated_label
        end

        it 'assigns the requested holding_location as @holding_location' do
          put :update, valid_params
          expect(assigns(:holding_location)).to eq(holding_location)
        end

        it 'passes flash notice message' do
          put :update, valid_params
          expect(flash[:notice]).to be_present
        end

        it 'redirects to the holding_location' do
          put :update, valid_params
          expect(response).to redirect_to(holding_location)
        end
      end

      context 'with invalid params' do
        it 'assigns the holding_location as @holding_location' do
          put :update, invalid_params
          expect(assigns(:holding_location)).to eq(holding_location)
        end

        it 'passes a flash error message' do
          put :update, invalid_params
          expect(flash[:error]).to be_present
        end

        it "re-renders the 'edit' template" do
          put :update, invalid_params
          expect(response).to render_template('edit')
        end
      end
    end

    describe 'DELETE #destroy' do
      it 'destroys the requested holding_location' do
        holding_location = FactoryGirl.create(:holding_location)
        expect do
          delete :destroy, params: { id: holding_location.code }
        end.to change(HoldingLocation, :count).by(-1)
      end

      it 'passes flash notice message' do
        holding_location = FactoryGirl.create(:holding_location)
        delete :destroy, params: { id: holding_location.code }
        expect(flash[:notice]).to be_present
      end

      it 'redirects to the holding_locations list' do
        holding_location = FactoryGirl.create(:holding_location)
        delete :destroy, params: { id: holding_location.code }
        expect(response).to redirect_to(holding_locations_path)
      end
    end
  end
end
