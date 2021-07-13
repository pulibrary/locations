# frozen_string_literal: true

require 'spec_helper'

module Locations
  describe Library, type: :model do
    subject { FactoryGirl.create(:library) }

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
          FactoryGirl.create(:library, code: subject.code)
        end.to raise_error ActiveRecord::RecordInvalid
      end

      describe 'code must follow naming conventions' do
        # TODO: Update this test when gem is updated.
        xit 'may not have spaces' do
          expect do
            FactoryGirl.create(:library, code: 'my code')
          end.to raise_error ActiveRecord::RecordInvalid
        end
        # TODO: Update this test when gem is updated.
        xit 'may not have capital letters' do
          expect do
            FactoryGirl.create(:library, code: 'myCode')
          end.to raise_error ActiveRecord::RecordInvalid
        end
        # TODO: Update this test when gem is updated.
        xit 'may not start with a number' do
          expect do
            FactoryGirl.create(:library, code: '42mycode')
          end.to raise_error ActiveRecord::RecordInvalid
        end
        it 'lets properly formed codes through' do
          expect do
            FactoryGirl.create(:library, code: 'mycode42')
          end.to_not raise_error
        end
        it 'new is a valid code for friendly_id' do
          expect do
            FactoryGirl.create(:library, code: 'new')
          end.to_not raise_error
        end
        it 'code can be 1 character' do
          expect do
            FactoryGirl.create(:library, code: 'f')
          end.to_not raise_error
        end
        it 'code can be 14 characters' do
          expect do
            FactoryGirl.create(:library, code: 'cotsenresearch')
          end.to_not raise_error
        end
        # TODO: Update this test when gem is updated.
        xit 'code may not be more than 14 characters' do
          expect do
            FactoryGirl.create(:library, code: 'thiscodeistooloong')
          end.to raise_error ActiveRecord::RecordInvalid
        end
        it 'may not be create' do
          expect do
            FactoryGirl.create(:library, code: 'create')
          end.to raise_error ActiveRecord::RecordInvalid
        end
      end
    end
  end
end
