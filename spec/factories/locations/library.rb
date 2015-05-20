require 'faker'

FactoryGirl.define do

  sequence(:code, 'a') { |n| "#{Faker::Lorem.characters(rand(2..6))}#{n}" }

  factory :library, class: Locations::Library do
    label { Faker::Company.name }
    code
  end

end
