require 'spec_helper'

module Locations
  describe Library, type: :model do

    subject { FactoryGirl.create(:library) }

    describe 'validations' do

      it 'factory creates a valid instance' do
        expect(subject.valid?).to be_truthy
      end

      it 'must have a label' do
        subject.label = nil
        expect(subject.valid?).to be_falsey
      end

      it 'must have a code' do
        subject.code = nil
        expect(subject.valid?).to be_falsey
      end

      it 'code must be unique' do
        expect {
          FactoryGirl.create(:library, code: subject.code)
        }.to raise_error ActiveRecord::RecordInvalid
      end

    end

  end
end
