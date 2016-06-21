require 'spec_helper'
require 'carrierwave/test/matchers'

module Locations
  describe Floor, type: :model do

    subject { FactoryGirl.create(:floor) }

    describe 'validations' do

      it 'factory creates a valid instance' do
        expect(subject.valid?).to be_truthy
      end

      it 'must have a library associated with it' do
        expect {
          FactoryGirl.create(:floor, library: nil)
        }.to raise_error ActiveRecord::RecordInvalid
      end

    end

    describe FloorplanUploader do
      include CarrierWave::Test::Matchers

      let(:uploader) { FloorplanUploader.new(subject, :floor_plan_image) }

      context 'the thumb version' do
        before do
          FloorplanUploader.enable_processing = true
          File.open(File.join(Rails.root, '/public/uploads/floorplan.png')) { |f| uploader.store!(f) }
        end

        after do
          FloorplanUploader.enable_processing = false
          uploader.remove!
        end

        it "scales down a landscape image to be no greater than 50 x 50" do
          expect(uploader.thumb).to be_no_wider_than(50)
          expect(uploader.thumb).to be_no_taller_than(50)
        end
      end

      context 'an unsupported format' do
        before do
          FloorplanUploader.enable_processing = true
        end

        after do
          FloorplanUploader.enable_processing = false
          uploader.remove!
        end

        it "only accepts jpg, png, and gif images" do
          expect {
            File.open(File.expand_path('../../../fixtures/not-image.txt', __FILE__)) { |f| uploader.store!(f) }
          }.to raise_error(CarrierWave::IntegrityError)
        end
      end
    end
  end
end
