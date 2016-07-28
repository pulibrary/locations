require 'spec_helper'

module Locations
  describe Map, type: :model do

    let(:locator) { FactoryGirl.create(:holding_location_locator) }
    let(:stackmap) { FactoryGirl.create(:holding_location_stackmap) }

    let(:subject_no_params) { described_class.new() }
    let(:subject_invalid_params) { described_class.new({id:'Foo',loc:'Bar!'}) }
    let(:subject_to_locator) { described_class.new({id:'4472547', loc: locator.code }) }
    let(:subject_to_stackmap) { described_class.new({id:'9547751', loc: stackmap.code }) }

    #let(:subject_unknown_loc) { described_class.new(fixture('/map_invalid_params.xml')) }
    #let(:subject_unknown_id) { described_class.new(fixture('/map_invalid_params.xml')) }

    #let(:subject_to_stackmap) { described_class.new(fixture('/map_to_stackmap.xml')) }
    #let(:subject_in_closed_location) { described_class.new(fixture('/map_in_closed_location.xml')) }


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
        it 'should return a url' do
          expect(subject_to_locator.url.include? 'locator').to be_truthy
        end
      end

      context 'stackmap location' do
        it 'should return a url' do
          expect(subject_to_stackmap.url.include? 'stackmap').to be_truthy
        end
      end

    end

  end
end
