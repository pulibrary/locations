require 'spec_helper'

module Locations
  describe 'HoldingLocation json view', type: :request do

    it 'Renders the json template' do
      get holding_locations_path, params: { format: :json }
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
            circulates: holding_location.circulates,
            remote_storage: holding_location.remote_storage,
            path: holding_location_path(holding_location, format: :json),
            library: {
              label: holding_location.library.label,
              code: holding_location.library.code,
              order: holding_location.library.order
            },
            holding_library: nil,
            hours_location: nil
          }
          expected << attrs
        end
        hl = FactoryGirl.create(:holding_location)
        hl.update(hours_location: FactoryGirl.create(:hours_location))
        hl.update(holding_library: FactoryGirl.create(:library))

        holding_location = HoldingLocation.last
        attrs = {
          label: holding_location.label,
          code: holding_location.code,
          aeon_location: holding_location.aeon_location,
          recap_electronic_delivery_location: holding_location.recap_electronic_delivery_location,
          open: holding_location.open,
          requestable: holding_location.requestable,
          always_requestable: holding_location.always_requestable,
          circulates: holding_location.circulates,
          remote_storage: holding_location.remote_storage,
          path: holding_location_path(holding_location, format: :json),
          library: {
            label: holding_location.library.label,
            code: holding_location.library.code,
            order: holding_location.library.order
          },
          holding_library: {
            label: holding_location.holding_library.label,
            code: holding_location.holding_library.code,
            order: holding_location.holding_library.order
          },
          hours_location: {
            label: holding_location.hours_location.label,
            code: holding_location.hours_location.code
          }
        }
        expected << attrs
        get holding_locations_path, params: { format: :json }
        expect(response.body).to eq expected.sort_by{ |k| k[:code] }.to_json
      end

      it "/holding_locations/{code} looks as we'd expect without hours_location" do
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
          circulates: holding_location.circulates,
          remote_storage: holding_location.remote_storage,
          library: {
            label: holding_location.library.label,
            code: holding_location.library.code,
            order: holding_location.library.order
          },
          holding_library: nil,
          hours_location: nil
        }

        expected[:delivery_locations] = []
        holding_location.delivery_locations.each do |dl|
          expected[:delivery_locations] << {
              label: dl.label,
              address: dl.address,
              phone_number: dl.phone_number,
              contact_email: dl.contact_email,
              gfa_pickup: dl.gfa_pickup,
              staff_only: dl.staff_only,
              pickup_location: dl.pickup_location,
              digital_location: dl.digital_location,
              library: { label: dl.library.label, 
                          code: dl.library.code,
                          order: dl.library.order
                        }
            }
        end
        get holding_location_path(holding_location), params: { format: :json }
        expect(response.body).to eq expected.to_json
      end

      it "/holding_locations/{code} looks as we'd expect with hours_location" do
        # Get extras in the db to make sure the association is OK
        FactoryGirl.create(:library)
        FactoryGirl.create(:delivery_location)
        holding_location = FactoryGirl.create(:holding_location)
        2.times do
          dl = FactoryGirl.create(:delivery_location)
          holding_location.delivery_locations << dl
        end
        holding_location.update(hours_location: FactoryGirl.create(:hours_location))
        holding_location.reload
        expected = {
          label: holding_location.label,
          code: holding_location.code,
          aeon_location: holding_location.aeon_location,
          recap_electronic_delivery_location: holding_location.recap_electronic_delivery_location,
          open: holding_location.open,
          requestable: holding_location.requestable,
          always_requestable: holding_location.always_requestable,
          circulates: holding_location.circulates,
          remote_storage: holding_location.remote_storage,
          library: {
            label: holding_location.library.label,
            code: holding_location.library.code,
            order: holding_location.library.order
          },
          holding_library: nil,
          hours_location: {
            label: holding_location.hours_location.label,
            code: holding_location.hours_location.code
          }
        }

        expected[:delivery_locations] = []
        holding_location.delivery_locations.each do |dl|
          expected[:delivery_locations] << {
              label: dl.label,
              address: dl.address,
              phone_number: dl.phone_number,
              contact_email: dl.contact_email,
              gfa_pickup: dl.gfa_pickup,
              staff_only: dl.staff_only,
              pickup_location: dl.pickup_location,
              digital_location: dl.digital_location,
              library: { label: dl.library.label, 
                          code: dl.library.code,
                          order: dl.library.order
                        }
            }
        end
        get holding_location_path(holding_location), params: { format: :json }
        expect(response.body).to eq expected.to_json
      end
      it "/holding_locations/{code} looks as we'd expect with holding_library" do
        # Get extras in the db to make sure the association is OK
        FactoryGirl.create(:library)
        FactoryGirl.create(:delivery_location)
        holding_location = FactoryGirl.create(:holding_location)
        2.times do
          dl = FactoryGirl.create(:delivery_location)
          holding_location.delivery_locations << dl
        end
        holding_location.update(holding_library: FactoryGirl.create(:library))
        holding_location.reload
        expected = {
          label: holding_location.label,
          code: holding_location.code,
          aeon_location: holding_location.aeon_location,
          recap_electronic_delivery_location: holding_location.recap_electronic_delivery_location,
          open: holding_location.open,
          requestable: holding_location.requestable,
          always_requestable: holding_location.always_requestable,
          circulates: holding_location.circulates,
          remote_storage: holding_location.remote_storage,
          library: {
            label: holding_location.library.label,
            code: holding_location.library.code,
            order: holding_location.library.order
          },
          holding_library: {
            label: holding_location.holding_library.label,
            code: holding_location.holding_library.code,
            order: holding_location.holding_library.order
          },
          hours_location: nil
        }

        expected[:delivery_locations] = []
        holding_location.delivery_locations.each do |dl|
          expected[:delivery_locations] << {
              label: dl.label,
              address: dl.address,
              phone_number: dl.phone_number,
              contact_email: dl.contact_email,
              gfa_pickup: dl.gfa_pickup,
              staff_only: dl.staff_only,
              pickup_location: dl.pickup_location,
              digital_location: dl.digital_location,
              library: { label: dl.library.label, 
                          code: dl.library.code,
                          order: dl.library.order
                        }
            }
        end
        get holding_location_path(holding_location), params: { format: :json }
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
            holding_location.circulates,
            holding_location.remote_storage,
            holding_location.library.code
          ]
          expected << attrs
        end
        hl = FactoryGirl.create(:holding_location)
        hl.update(hours_location: FactoryGirl.create(:hours_location))
        hl.update(holding_library: FactoryGirl.create(:library))
        holding_location = HoldingLocation.last
        attrs = [
          CGI::escapeHTML(holding_location.label),
          holding_location.code,
          holding_location.aeon_location,
          holding_location.recap_electronic_delivery_location,
          holding_location.open,
          holding_location.requestable,
          holding_location.always_requestable,
          holding_location.circulates,
          holding_location.remote_storage,
          holding_location.library.code,
          holding_location.hours_location.code
        ]
        expected << attrs
        expected << ['Aeon Location', 'ReCAP EDD',
         'Open', 'Requestable', 'Always Requestable', 'Hours Location']
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
        holding_location.update(hours_location: FactoryGirl.create(:hours_location))
        holding_location.reload
        expected = [
          CGI::escapeHTML(holding_location.label),
          holding_location.code,
          holding_location.aeon_location,
          holding_location.recap_electronic_delivery_location,
          holding_location.open,
          holding_location.requestable,
          holding_location.always_requestable,
          holding_location.circulates,
          holding_location.remote_storage,
          holding_location.library.code,
          holding_location.hours_location.code
        ]
        holding_location.delivery_locations.each {
          |dl| expected << CGI::escapeHTML(dl.label) }
        get holding_location_path(holding_location)
        expected.each {|e| expect(response.body).to include(e.to_s)}
      end

    end

  end
end
