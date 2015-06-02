require 'spec_helper'

module Locations
  describe 'HoldingLocation json view', type: :request do

    it 'Renders the json template' do
      get holding_locations_path, format: :json
      expect(response).to render_template(:index)
      expect(response.content_type).to eq 'application/json'
    end

    describe 'the response body' do

      it "/holding_locations looks as we'd expect" do
        2.times { FactoryGirl.create(:holding_location) }
        expected = []
        HoldingLocation.all.each do |holding_location|
          attrs = {
            label: holding_location.label,
            code: holding_location.code,
            aeon_location: holding_location.aeon_location,
            recap_electronic_delivery_location: holding_location.recap_electronic_delivery_location,
            open: holding_location.open,
            requestable: holding_location.requestable,
            always_requestable: holding_location.always_requestable,
            path: holding_location_path(holding_location, format: :json),
            library: {
              label: holding_location.library.label,
              code: holding_location.library.code
            }
          }
          expected << attrs
        end
        get holding_locations_path, format: :json
        expect(response.body).to eq expected.to_json

      end

      it "/holding_locations/{code} looks as we'd expect" do
        # Get extras in the db to make sure the association is OK
        FactoryGirl.create(:library)
        FactoryGirl.create(:delivery_location)
        holding_location = FactoryGirl.create(:holding_location)
        2.times do
          dl = FactoryGirl.create(:delivery_location)
          holding_location.delivery_locations << dl
        end
        holding_location.reload
        expected = {
          label: holding_location.label,
          code: holding_location.code,
          aeon_location: holding_location.aeon_location,
          recap_electronic_delivery_location: holding_location.recap_electronic_delivery_location,
          open: holding_location.open,
          requestable: holding_location.requestable,
          always_requestable: holding_location.always_requestable,
          library: {
            label: holding_location.library.label,
            code: holding_location.library.code
          }
        }


        Library.all.each do |library|
          expected[library.code] = holding_location.send("#{library.code}?")
        end
        expected[:delivery_locations] = []
        holding_location.delivery_locations.each do |dl|
          expected[:delivery_locations] << {
              label: dl.label,
              address: dl.address,
              phone_number: dl.phone_number,
              contact_email: dl.contact_email,
              gfa_pickup: dl.gfa_pickup,
              staff_only: dl.staff_only,
              pickup_location: dl.pickup_location            
            }
        end
        get holding_location_path(holding_location), format: :json
        expect(response.body).to eq expected.to_json
      end

    end


  end

  describe 'HoldingLocation html view', type: :request do

    it 'Renders the html template by default' do
      get holding_locations_path
      expect(response).to render_template(:index)
      expect(response.content_type).to eq 'text/html'
    end

    describe 'the response body' do

      it "/holding_locations contains expected fields" do
        2.times { FactoryGirl.create(:holding_location) }
        expected = []
        HoldingLocation.all.each do |holding_location|
          attrs = [
            CGI::escapeHTML(holding_location.label),
            holding_location.code,
            holding_location.aeon_location,
            holding_location.recap_electronic_delivery_location,
            holding_location.open,
            holding_location.requestable,
            holding_location.always_requestable,
            holding_location.library.code
          ]
          expected << attrs
        end
        expected << ['Aeon Location', 'ReCAP Electronic Delivery Location',
         'Open', 'Requestable', 'Always Requestable']
        get holding_locations_path
        expected.flatten.uniq.each {|e| expect(response.body).to include(e.to_s)}

      end

      it "/holding_locations/{code} contains expected fields" do
        FactoryGirl.create(:library)
        FactoryGirl.create(:delivery_location)
        holding_location = FactoryGirl.create(:holding_location)
        2.times do
          dl = FactoryGirl.create(:delivery_location)
          holding_location.delivery_locations << dl
        end
        holding_location.reload
        expected = [
          CGI::escapeHTML(holding_location.label),
          holding_location.code,
          holding_location.aeon_location,
          holding_location.recap_electronic_delivery_location,
          holding_location.open,
          holding_location.requestable,
          holding_location.always_requestable,
          holding_location.library.code
        ]
        holding_location.delivery_locations.each {
          |dl| expected << CGI::escapeHTML(dl.label) }
        get holding_location_path(holding_location)
        expected.each {|e| expect(response.body).to include(e.to_s)}
      end

    end

  end
end
