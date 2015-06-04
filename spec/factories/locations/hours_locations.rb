require 'faker'

FactoryGirl.define do

  factory :hours_location, class: Locations::HoursLocation do
    label { Faker::Company.name + ' Library'}
    code
  end

end