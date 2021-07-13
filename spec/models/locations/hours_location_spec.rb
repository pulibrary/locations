# frozen_string_literal: true

require 'spec_helper'

module Locations
  describe HoursLocation, type: :model do
    subject { FactoryGirl.create(:hours_location) }

    describe 'validations' do
      it 'factory creates a valid instance' do
        expect(subject.valid?).to be_truthy
      end

      %i[label code].each do |a|
        it "is not valid without a #{a}" do
          subject.send("#{a}=", nil)
          expect(subject.valid?).to be_falsey
        end
      end

      it 'code must be unique' do
        expect do
          FactoryGirl.create(:hours_location, code: subject.code)
        end.to raise_error ActiveRecord::RecordInvalid
      end
    end
  end
end
