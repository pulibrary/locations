require 'spec_helper'

module Locations
  describe Floor, type: :model do

    subject { FactoryGirl.create(:floor) }

    describe 'validations' do

      it 'factory creates a valid instance' do
        expect(subject.valid?).to be_truthy
      end

      it 'must have a library associated with it' do
        expect {
          FactoryGirl.create(:floor, library: nil)
        }.to raise_error ActiveRecord::RecordInvalid
      end

    end
  end
end
