require 'faker'

FactoryGirl.define do
  factory :floor, class: 'Locations::Floor' do
    label { 'Floor ' + Faker::Number.number(10).to_s }
    floor_plan_uri { Faker::Internet.url }
    starting_point "10,10,10,10"
    walkable_areas "<svg></svg>"
  end

end
