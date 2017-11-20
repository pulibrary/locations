require 'spec_helper'

module Locations
  describe MapController, type: :controller do
    routes { Locations::Engine.routes }

    let(:params) { { id: id, loc: loc } }
    let(:map) { Locations::Map.new(id: id, loc: loc) }
    let(:map_bibdata) { "https://bibdata.princeton.edu/bibliographic/#{map.id}/solr" }

    describe 'GET #index' do
      context 'with locator params' do
        let(:id) { '4472547' }
        let(:loc) { holding_location.code }
        let(:holding_location) { FactoryGirl.create(:holding_location_locator, library_args: { code: 'firestone' }) }

        before { stub_request(:get, map_bibdata).to_return(status: 200, body: fixture('locator_bibrec.json')) }

        it 'redirects to the locator url' do
          get :index, params, {}
          expect(response).to redirect_to("http://library.princeton.edu/locator/index.php?loc=#{map.loc}&id=#{map.id}")
        end
      end

      context 'with stackmap params' do
        let(:id) { '9547751' }
        let(:loc) { holding_location.code }
        let(:callno) { map.bibrec['call_number_display'].first }
        let(:holding_location) { FactoryGirl.create(:holding_location_stackmap, library_args: { code: 'lewis' }) }

        before { stub_request(:get, map_bibdata).to_return(status: 200, body: fixture('stackmap_bibrec.json')) }

        it 'redirects to the stackmap url' do
          get :index, params, {}
          expect(response).to redirect_to(URI.encode("http://princeton.stackmap.com/view/?callno=#{callno}&location=#{map.loc}&library=#{map.lib.label}"))
        end
      end

      context 'with closed stack reserves' do
        let(:id) { '9547751' }
        let(:loc) { holding_location.code }
        let(:holding_location) { FactoryGirl.create(:holding_location_stackmap_closed, library_args: { code: 'stokes' }) }

        before { stub_request(:get, map_bibdata).to_return(status: 200, body: '{}') }

        it 'returns a message to user via index template' do
          get :index, params, {}
          expect(response).to render_template(:index)
        end
      end

      context 'with invalid params' do
        let(:id) { 'Foo' }
        let(:loc) { 'Bar!' }

        it 'returns an Bad Request 400 error' do
          get :index, params, {}
          expect(response.status).to eq 400
        end
      end

      context 'with missing loc param' do
        let(:id) { '4472547' }
        let(:loc) { nil }

        it 'returns an Bad Request 400 error' do
          get :index, params, {}
          expect(response.status).to eq 400
        end
      end

      context 'with missing loc param' do
        let(:id) { nil }
        let(:loc) { 'f' }

        it 'returns an Bad Request 400 error' do
          get :index, params, {}
          expect(response.status).to eq 400
        end
      end

      context 'with no params' do
        let(:params) { {} }

        it 'returns an Bad Request 400 error' do
          get :index, params, {}
          expect(response.status).to eq 400
        end
      end
    end
  end
end
