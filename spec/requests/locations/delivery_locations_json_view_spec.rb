require 'spec_helper'

module Locations
  describe 'DeliveryLocation json view', type: :request do

    it 'Renders the json template' do
      get delivery_locations_path, format: :json
      expect(response).to render_template(:index)
      expect(response.content_type).to eq 'application/json'
    end

    describe 'the response body' do

      it "/delivery_locations looks as we'd expect" do
        2.times { FactoryGirl.create(:delivery_location) }
        expected = []
        DeliveryLocation.all.each do |delivery_location|
          attrs = {
            label: delivery_location.label,
            address: delivery_location.address,
            phone_number: delivery_location.phone_number,
            contact_email: delivery_location.contact_email,
            gfa_pickup: delivery_location.gfa_pickup,
            staff_only: delivery_location.staff_only,
            pickup_location: delivery_location.pickup_location,
            path: delivery_location_path(delivery_location, format: :json)
          }
          expected << attrs
        end
        get delivery_locations_path, format: :json
        expect(response.body).to eq expected.to_json

      end

      it "/delivery_locations/{code} looks as we'd expect" do
        delivery_location = FactoryGirl.create(:delivery_location)
        expected = {
          label: delivery_location.label,
          address: delivery_location.address,
          phone_number: delivery_location.phone_number,
          contact_email: delivery_location.contact_email,
          gfa_pickup: delivery_location.gfa_pickup,
          staff_only: delivery_location.staff_only,
          pickup_location: delivery_location.pickup_location
        }
        get delivery_location_path(delivery_location), format: :json
        expect(response.body).to eq expected.to_json
      end

    end
  end
end
