require 'spec_helper'

module Locations
  describe 'Library json view', type: :request do

    it 'Renders the json template' do
      get libraries_path, format: :json
      expect(response).to render_template(:index)
      expect(response.content_type).to eq 'application/json'
    end

    describe 'the response body' do

      it "/libraries looks as we'd expect" do
        2.times { FactoryGirl.create(:library) }
        expected = []
        Library.all.each do |library|
          attrs = {
            label: library.label,
            code: library.code,
            path: library_path(library, format: :json)
          }
          expected << attrs
        end
        get libraries_path, format: :json
        expect(response.body).to eq expected.to_json

      end

      it "/libraries/{code} looks as we'd expect" do
        library = FactoryGirl.create(:library)
        expected = {
          label: library.label,
          code: library.code
        }
        get library_path(library), format: :json
        expect(response.body).to eq expected.to_json
      end

    end
  end
end
