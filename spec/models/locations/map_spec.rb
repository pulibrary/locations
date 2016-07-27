require 'spec_helper'

module Locations
  describe Map, type: :model do
    let(:subject_no_params) { described_class.new() }
    let(:subject_invalid_params) { described_class.new({id:'Foo',loc:'Bar!'}) }
    #let(:subject_unknown_loc) { described_class.new(fixture('/map_invalid_params.xml')) }
    #let(:subject_unknown_id) { described_class.new(fixture('/map_invalid_params.xml')) }
    let(:subject_to_locator) { described_class.new({id:'4472547',loc:'f'}) }
    #let(:subject_to_stackmap) { described_class.new(fixture('/map_to_stackmap.xml')) }
    #let(:subject_in_closed_location) { described_class.new(fixture('/map_in_closed_location.xml')) }


    describe 'validations' do

      it 'creates a valid instance' do
        expect(subject_to_locator.valid?).to be_truthy
      end

      it 'must have params' do
        expect(subject_no_params.valid?).to be_falsey
      end

      it 'must have valid params' do
        expect(subject_invalid_params.valid?).to be_falsey
      end

      it 'id must be a numeric string' do
        expect(subject_to_locator[:id]).to be_a_kind_of(String)
        expect(subject_to_locator[:id]).to match(/^[0-9]+$/)
      end

      it 'loc must be alpha-numeric string' do
        expect(subject_to_locator[:loc]).to be_a_kind_of(String)
        expect(subject_to_locator[:loc]).to match(/^[a-zA-Z0-9]+$/)
      end


    end

  end
end
