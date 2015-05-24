require 'faker'

FactoryGirl.define do

  factory :library, class: Locations::Library do
    label { Faker::Company.name + ' Library'}
    code
  end

end
