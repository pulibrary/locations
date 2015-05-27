require 'spec_helper'

module Locations
  describe DeliveryLocationsController, type: :controller do 
    routes { Locations::Engine.routes }

    let(:invalid_attributes) {
      FactoryGirl.attributes_for(:delivery_location, label: nil)
    }

    let(:valid_session) { {} }

    describe 'GET #index' do
      render_views

      it 'assigns all delivery_locations as @delivery_locations' do
        delivery_location = FactoryGirl.create(:delivery_location)
        get :index, {}, valid_session
        expect(assigns(:delivery_locations)).to eq([delivery_location])
      end

      it 'delivery_locations is active in navbar' do
        get :index, {}, valid_session
        expect(response.body.include?('<li class="active"><a href="/locations/delivery_locations')).to eq true       
      end
      
    end

    describe 'GET #show' do
      it 'assigns the requested delivery_location as @delivery_location' do
        delivery_location = FactoryGirl.create(:delivery_location)
        get :show, { id: delivery_location.to_param }, valid_session
        expect(assigns(:delivery_location)).to eq(delivery_location)
      end
    end

    describe 'GET #new' do
      it 'assigns a new delivery_location as @delivery_location' do
        get :new, {}, valid_session
        expect(assigns(:delivery_location)).to be_a_new(DeliveryLocation)
      end
    end

    describe 'GET #edit' do
      it 'assigns the requested delivery_location as @delivery_location' do
        delivery_location = FactoryGirl.create(:delivery_location)
        get :edit, { id: delivery_location.to_param }, valid_session
        expect(assigns(:delivery_location)).to eq(delivery_location)
      end
    end

    describe 'POST #create' do
      let(:valid_attributes) {
        attrs = FactoryGirl.attributes_for(:delivery_location)
        library = FactoryGirl.create(:library)
        attrs[:locations_library_id] = library.id
        attrs
      }
      context 'with valid params' do
        it 'creates a new DeliveryLocation' do
          expect {
            post :create, { delivery_location: valid_attributes }, valid_session
          }.to change(DeliveryLocation, :count).by(1)
        end

        it 'assigns a newly created delivery_location as @delivery_location' do
          post :create, { delivery_location: valid_attributes }, valid_session
          expect(assigns(:delivery_location)).to be_a(DeliveryLocation)
          expect(assigns(:delivery_location)).to be_persisted
        end

        it 'passes flash notice message' do
          post :create, { delivery_location: valid_attributes }, valid_session
          expect(flash[:notice]).to be_present
        end

        it 'redirects to the created delivery_location' do
          post :create, { delivery_location: valid_attributes }, valid_session
          expect(response).to redirect_to(DeliveryLocation.last)
        end
      end

      context 'with invalid params' do

        it 'assigns a newly created but unsaved delivery_location as @delivery_location' do
          post :create, { delivery_location: invalid_attributes }, valid_session
          expect(assigns(:delivery_location)).to be_a_new(DeliveryLocation)
        end

        it 'passes flash error message' do
          post :create, { delivery_location: invalid_attributes }, valid_session
          expect(flash[:error]).to be_present
        end

        it 're-renders the "new" template' do
          post :create, { delivery_location: invalid_attributes }, valid_session
          expect(response).to render_template('new')
        end
      end
    end

    describe 'PUT #update' do
      context 'with valid params' do
        let(:updated_label) { 'Updated Label'}
        let(:new_attributes) {
          FactoryGirl.attributes_for(:delivery_location, label: updated_label)
        }

        it 'updates the requested delivery_location' do
          delivery_location = FactoryGirl.create(:delivery_location)
          put :update, {:id => delivery_location.to_param, delivery_location: new_attributes }, valid_session
          delivery_location.reload
          expect(delivery_location.label).to eq updated_label
        end

        it 'assigns the requested delivery_location as @delivery_location' do
          delivery_location = FactoryGirl.create(:delivery_location)
          put :update, { :id => delivery_location.to_param, delivery_location: new_attributes }, valid_session
          expect(assigns(:delivery_location)).to eq(delivery_location)
        end

        it 'passes flash notice message' do
          delivery_location = FactoryGirl.create(:delivery_location)
          put :update, {:id => delivery_location.to_param, delivery_location: new_attributes }, valid_session
          expect(flash[:notice]).to be_present
        end

        it 'redirects to the delivery_location' do
          delivery_location = FactoryGirl.create(:delivery_location)
          put :update, {:id => delivery_location.to_param, delivery_location: new_attributes }, valid_session
          expect(response).to redirect_to(delivery_location)
        end
      end

      context 'with invalid params' do
        it 'assigns the delivery_location as @delivery_location' do
          delivery_location = FactoryGirl.create(:delivery_location)
          put :update, {:id => delivery_location.to_param, delivery_location: invalid_attributes }, valid_session
          expect(assigns(:delivery_location)).to eq(delivery_location)
        end

        it 'passes a flash error message' do
          delivery_location = FactoryGirl.create(:delivery_location)
          put :update, {:id => delivery_location.to_param, delivery_location: invalid_attributes }, valid_session
          expect(flash[:error]).to be_present
        end

        it 're-renders the "edit" template' do
          delivery_location = FactoryGirl.create(:delivery_location)
          put :update, {:id => delivery_location.to_param, delivery_location: invalid_attributes }, valid_session
          expect(response).to render_template('edit')
        end
      end
    end

    describe 'DELETE #destroy' do
      it 'destroys the requested delivery_location' do
        delivery_location = FactoryGirl.create(:delivery_location)
        expect {
          delete :destroy, { id: delivery_location.to_param }, valid_session
        }.to change(DeliveryLocation, :count).by(-1)
      end

      it 'passes flash notice message' do
        delivery_location = FactoryGirl.create(:delivery_location)
        delete :destroy, { id: delivery_location.to_param }, valid_session
        expect(flash[:notice]).to be_present
      end

      it 'redirects to the delivery_locations list' do
        delivery_location = FactoryGirl.create(:delivery_location)
        delete :destroy, { id: delivery_location.to_param }, valid_session
        expect(response).to redirect_to(delivery_locations_path)
      end
    end

  end
end
