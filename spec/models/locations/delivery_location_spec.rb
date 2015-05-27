require 'spec_helper'

module Locations
  describe DeliveryLocation, type: :model do

    subject { FactoryGirl.create(:delivery_location) }

    describe 'validations' do
      it 'factory produces a valid subject' do
        expect(subject.valid?).to be_truthy
      end

      [:label, :address, :phone_number, :contact_email, :gfa_pickup, :staff_only, :pickup_location].each do |a|
        it "is not valid without a #{a}" do
          subject.send("#{a}=", nil)
          expect(subject.valid?).to be_falsey
        end
      end
    end

    describe 'holding locations association' do
      it 'can have holding locations' do
        holding_location = FactoryGirl.create(:holding_location)
        expect {
          subject.holding_locations << holding_location
        }.to_not raise_error
      end

      it 'appends holding locations as expected' do
        2.times do
          holding_location = FactoryGirl.create(:holding_location)
          subject.holding_locations << holding_location
        end
        subject.reload
        expect(subject.holding_locations.count).to eq 2
      end
    end

  end
end
