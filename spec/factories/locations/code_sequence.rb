require 'faker'

FactoryGirl.define do
  sequence(:code, 'a') do |n|
    "#{('a'..'z').to_a[rand(26)]}#{Faker::Lorem.characters(rand(1..6)).downcase}#{n}"
  end
end
