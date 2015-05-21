require 'spec_helper'

module Locations
  describe HoldingLocation, type: :model do

    subject { FactoryGirl.create(:holding_location) }

    describe 'validations' do
      it 'factory produces a valid subject' do
        expect(subject.valid?).to be_truthy
      end

      [:label, :code, :is_aeon_location, :is_recap_electronic_delivery_location,
        :is_open, :is_requestable, :is_always_requestable].each do |a|
        it "is not valid without a #{a}" do
          subject.send("#{a}=", nil)
          expect(subject.valid?).to be_falsey
        end
      end

      it 'code must be unique' do
        expect {
          FactoryGirl.create(:holding_location, code: subject.code)
        }.to raise_error ActiveRecord::RecordInvalid
      end
    end

    describe 'delivery locations association' do
      it 'can have delivery locations' do
        delivery_location = FactoryGirl.create(:delivery_location)
        expect {
          subject.delivery_locations << delivery_location
        }.to_not raise_error
      end

      it 'appends delivery locations as expected' do
        3.times do
          delivery_location = FactoryGirl.create(:delivery_location)
          subject.delivery_locations << delivery_location
        end
        subject.reload
        expect(subject.delivery_locations.count).to eq 3
      end
    end
  end
end
