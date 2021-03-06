require 'spec_helper'

module Locations
  describe Library, type: :model do

    subject { FactoryGirl.create(:library) }

    describe 'validations' do

      it 'factory creates a valid instance' do
        expect(subject.valid?).to be_truthy
      end

      [:label, :code].each do |a|
        it "is not valid without a #{a}" do
          subject.send("#{a}=", nil)
          expect(subject.valid?).to be_falsey
        end
      end

      it 'code must be unique' do
        expect {
          FactoryGirl.create(:library, code: subject.code)
        }.to raise_error ActiveRecord::RecordInvalid
      end

      describe 'code must follow naming conventions' do
        # TODO: Update this test when gem is updated.
        xit 'may not have spaces' do
          expect {
            FactoryGirl.create(:library, code: 'my code')
          }.to raise_error ActiveRecord::RecordInvalid
        end
        # TODO: Update this test when gem is updated.
        xit 'may not have capital letters' do
          expect {
            FactoryGirl.create(:library, code: 'myCode')
          }.to raise_error ActiveRecord::RecordInvalid
        end
        # TODO: Update this test when gem is updated.
        xit 'may not start with a number' do
          expect {
            FactoryGirl.create(:library, code: '42mycode')
          }.to raise_error ActiveRecord::RecordInvalid
        end
        it 'lets properly formed codes through' do
          expect {
            FactoryGirl.create(:library, code: 'mycode42')
          }.to_not raise_error
        end
        it 'new is a valid code for friendly_id' do
          expect {
            FactoryGirl.create(:library, code: 'new')
          }.to_not raise_error
        end
        it 'code can be 1 character' do
          expect {
            FactoryGirl.create(:library, code: 'f')
          }.to_not raise_error
        end
        it 'code can be 14 characters' do
          expect {
            FactoryGirl.create(:library, code: 'cotsenresearch')
          }.to_not raise_error
        end
        # TODO: Update this test when gem is updated.
        xit 'code may not be more than 14 characters' do
          expect {
            FactoryGirl.create(:library, code: 'thiscodeistooloong')
          }.to raise_error ActiveRecord::RecordInvalid
        end
        it 'may not be create' do
          expect {
            FactoryGirl.create(:library, code: 'create')
          }.to raise_error ActiveRecord::RecordInvalid
        end
      end
    end
  end
end
