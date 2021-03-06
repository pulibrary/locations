require 'spec_helper'

module Locations
  describe HoldingLocation, type: :model do

    subject { FactoryGirl.create(:holding_location) }

    describe 'validations' do
      it 'factory produces a valid subject' do
        expect(subject.valid?).to be_truthy
      end

      [:code, :aeon_location, :recap_electronic_delivery_location,
        :open, :requestable, :always_requestable, :circulates].each do |a|
        it "is not valid without a #{a}" do
          subject.send("#{a}=", nil)
          expect(subject.valid?).to be_falsey
        end
      end

      it "is valid without a label" do
        subject.send("label=", nil)
        expect(subject.valid?).to eq true
      end

      it "is valid without a remote_storage" do
        subject.send("remote_storage=", nil)
        expect(subject.valid?).to eq true
      end

      it 'code must be unique' do
        expect {
          FactoryGirl.create(:holding_location, code: subject.code)
        }.to raise_error ActiveRecord::RecordInvalid
      end

      it 'must have a library associated with it' do
        expect {
          FactoryGirl.create(:holding_location, library: nil)
        }.to raise_error ActiveRecord::RecordInvalid
      end
    end

    describe 'hours locations association' do
      it 'can have an hours location' do
        hours_location = FactoryGirl.create(:hours_location)
        expect {
          subject.update(hours_location: hours_location)
        }.to_not raise_error
      end
    end

    describe 'holding library association' do
      it 'can have a holding library' do
        holding_library = FactoryGirl.create(:library)
        expect {
          subject.update(holding_library: holding_library)
        }.to_not raise_error
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
        expect(subject.delivery_locations.count).to eq 3
      end

      it 'associates all non-staff-only delivery locations by default' do
        public_dls = []
        staff_only_dls = []
        2.times do
          public_dls << FactoryGirl.create(:delivery_location, staff_only: false)
          staff_only_dls << FactoryGirl.create(:delivery_location, staff_only: true)
        end
        expect(subject.delivery_locations).to eq public_dls
      end
    end

  end
end
