require 'spec_helper'

module Locations
  describe Library, type: :model do

    subject { FactoryGirl.create(:library) }

    describe 'validations' do

      it 'factory creates a valid instance' do
        expect(subject.valid?).to be_truthy
      end
    end
  end
end
