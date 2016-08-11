require 'spec_helper'

module Locations
  describe MapController, type: :controller do

    routes { Locations::Engine.routes }

    let(:locator) { FactoryGirl.create(:holding_location_locator, library_args: {code: 'firestone'}) }
    let(:stackmap) { FactoryGirl.create(:holding_location_stackmap, library_args: {code: 'lewis'}) }
    let(:closed_stack_reserves) { FactoryGirl.create(:holding_location_stackmap_closed, library_args: {code: 'stokes'}) }

    let(:subject_to_locator) { Locations::Map.new({id:'4472547', loc: locator.code }) }
    let(:subject_to_stackmap) { Locations::Map.new({id:'9547751', loc: stackmap.code }) }
    let(:subject_closed_reserves) { Locations::Map.new({id:'9547751', loc: closed_stack_reserves.code }) }

    let(:locator_params) { {:id => '4472547', :loc => locator.code} }
    let(:stackmap_params) { {:id => '9547751', :loc => stackmap.code} }
    let(:no_params) { {} }
    let(:invalid_params) { {:id => 'Foo', :loc => 'Bar!'} }

    let(:valid_session) { {} }

    let(:locator_bibdata) { "https://bibdata.princeton.edu/bibliographic/#{subject_to_locator.id}/solr" }
    let(:stackmap_bibdata) { "https://bibdata.princeton.edu/bibliographic/#{subject_to_stackmap.id}/solr" }
    let(:callno) { subject_to_stackmap.bibrec['call_number_display'].first }

    before    {
      stub_request(:get, locator_bibdata).to_return(:status => 200, :body => fixture('locator_bibrec.json'))
      stub_request(:get, stackmap_bibdata).to_return(:status => 200, :body => fixture('stackmap_bibrec.json'))
    }

    describe "GET #index" do

      it 'with locator params it redirects to the locator url' do
        get :index, locator_params, valid_session
        expect(response).to redirect_to("http://library.princeton.edu/locator/index.php?loc=#{subject_to_locator.loc}&id=#{subject_to_locator.id}")
      end

      it 'with stackmap params it redirects to the stackmap url' do
        get :index, stackmap_params, valid_session
        expect(response).to redirect_to(URI.encode("http://princeton.stackmap.com/view/?callno=#{callno}&location=#{subject_to_stackmap.loc}&library=#{subject_to_stackmap.lib.label}"))
      end

      it 'with invalid params it returns an Bad Request 400 error' do
        get :index, invalid_params, valid_session
        expect(response.status).to eq 400
      end

      it 'with no params it returns an Bad Request 400 error' do
        get :index, no_params, valid_session
        expect(response.status).to eq 400
      end

      context 'closed stack reserves' do
        it 'should return a message to visit the circ desk of the appropriate library' do
          expect(subject_closed_reserves.url.include? 'This item is currently in a reserve location').to be_truthy
        end
      end

    end

  end
end
