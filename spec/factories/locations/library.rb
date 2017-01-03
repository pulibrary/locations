require 'faker'

FactoryGirl.define do

  factory :library, class: Locations::Library do
    label { Faker::Company.name + ' Library'}
    code
    order { rand(0..10) }
  end

end
