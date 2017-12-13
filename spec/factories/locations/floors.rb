require 'faker'

FactoryGirl.define do
  factory :floor, class: 'Locations::Floor' do
    label { 'Floor ' + Faker::Number.number(10).to_s }
    floor_plan_image Rack::Test::UploadedFile.new('.internal_test_app/public/uploads/floorplan.png')
    starting_point "10,10,10,10"
    walkable_areas "<svg></svg>"
    library

    after :create do |b|
      b.update_column(:floor_plan_image, "foo/bar/baz.png")
    end
  end
end
