require 'spec_helper'

module Locations
  describe HoldingLocation, type: :model do

    subject { FactoryGirl.create(:holding_location) }

    describe 'validations' do
      it 'factory produces a valid subject' do
        expect(subject.valid?).to be_truthy
      end

      [:label, :code, :aeon_location, :recap_electronic_delivery_location,
        :open, :requestable, :always_requestable].each do |a|
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
        subject.delivery_locations.each { |dl| puts dl.id }
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

    describe 'metaprogrammed boolean methods' do
      it 'associated library adds a boolean method based on its :code' do
        associated_library = FactoryGirl.create(:library, code: 'firestone')
        unassociated_library = FactoryGirl.create(:library, code: 'recap')
        subject.library.destroy
        subject.library = associated_library
        expect { subject.firestone? }.to_not raise_error
        expect { subject.recap? }.to_not raise_error
        expect(subject.methods.include?(:firestone?)).to be_truthy
        expect(subject.methods.include?(:recap?)).to be_truthy
        expect(subject.firestone?).to be_truthy
        expect(subject.recap?).to be_falsey
      end

    end

  end
end
