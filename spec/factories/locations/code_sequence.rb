require 'faker'

FactoryGirl.define do
  sequence(:code, 'a') do |n|
    "#{Faker::Lorem.characters(rand(2..6))}#{n}"
  end
end
