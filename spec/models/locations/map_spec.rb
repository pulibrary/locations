require 'spec_helper'

module Locations
  describe Map, type: :model do

    let(:locator) { FactoryGirl.create(:holding_location_locator, library_args: {code: 'firestone'}) }
    let(:stackmap) { FactoryGirl.create(:holding_location_stackmap, library_args: {code: 'lewis'}) }
    let(:unmappable) { FactoryGirl.create(:holding_location, library_args: {code: 'foo'}) }
    let(:closed_stack_reserves) { FactoryGirl.create(:holding_location_stackmap_closed, library_args: {code: 'lewis'}) }

    let(:subject_no_params) { described_class.new() }
    let(:subject_invalid_params) { described_class.new({id:'Foo',loc:'Bar!'}) }
    let(:subject_to_locator) { described_class.new({id:'4472547', loc: locator.code }) }
    let(:subject_to_stackmap) { described_class.new({id:'9547751', loc: stackmap.code }) }
    let(:subject_unmappable) { described_class.new({id:'9547751', loc: unmappable.code }) }
    let(:subject_closed_reserves) { described_class.new({id:'9547751', loc: closed_stack_reserves.code }) }
    let(:subject_callno_by_title) { described_class.new({id:'9585183', loc: stackmap.code }) }

    let(:locator_bibdata) { "https://bibdata.princeton.edu/bibliographic/#{subject_to_locator.id}/solr" }
    let(:stackmap_bibdata) { "https://bibdata.princeton.edu/bibliographic/#{subject_to_stackmap.id}/solr" }
    before    {
      stub_request(:get, locator_bibdata).to_return(:status => 200, :body => fixture('locator_bibrec.json'))
      stub_request(:get, stackmap_bibdata).to_return(:status => 200, :body => fixture('stackmap_bibrec.json'))
    }

    describe 'validations' do

      it 'creates a valid instance' do
        expect(subject_to_locator.is_valid?).to be_truthy
      end

      it 'must have params' do
        expect(subject_no_params.is_valid?).to be_falsey
      end

      it 'must have valid params' do
        expect(subject_invalid_params.is_valid?).to be_falsey
      end

      it 'id must be a numeric string' do
        expect(subject_to_locator.id).to be_a_kind_of(String)
        expect(subject_to_locator.id).to match(/^[0-9]+$/)
      end

      it 'loc must be alpha-numeric string' do
        expect(subject_to_locator.loc).to be_a_kind_of(String)
        expect(subject_to_locator.loc).to match(/^[a-zA-Z0-9]+$/)
      end

      context 'locator location' do
        it 'should return the locator url' do
          expect(subject_to_locator.url.include? 'locator').to be_truthy
        end
      end

      context 'stackmap location' do
        it 'should return the stackmap url' do
          expect(subject_to_stackmap.url.include? 'stackmap').to be_truthy
        end
      end

      context 'unmappable library' do
        it 'should return the item request url' do
          expect(subject_unmappable.url.include? 'requests').to be_truthy
        end
      end

      context 'closed stack reserves' do
        it 'should return a message to visit the circ desk of the appropriate library' do
          #puts subject_closed_reserves.url
          #expect(subject_closed_reserves.url.include? 'This item is currently in a reserve location please see the circulation desk at the #{subject_closed_reserves.lib.label} to get an available copy.').to be_truthy
          skip("Todo...")
        end
      end

      context 'by title location' do
        it 'should return the item request url' do
          #expect(subject_callno_by_title.url.include? 'requests').to be_truthy
          skip("Todo...")
        end
      end

    end

  end
end
