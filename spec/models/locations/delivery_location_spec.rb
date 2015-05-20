require 'spec_helper'

module Locations
  describe DeliveryLocation, type: :model do

    subject { FactoryGirl.create(:delivery_location) }

    describe 'validations' do

      it 'factory produces a valid subject' do
        expect(subject.valid?).to be_truthy
      end

      [:label, :address, :phone_number, :contact_email, :staff_only].each do |a|
        it "is not valid without a #{a}" do
          subject.send("#{a}=", nil)
          expect(subject.valid?).to be_falsey
        end
      end

    end
  end
end
