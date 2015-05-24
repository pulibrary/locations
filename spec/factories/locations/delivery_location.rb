require 'faker'

Faker::Config.locale = 'en-US'

FactoryGirl.define do

  factory :delivery_location, class: Locations::DeliveryLocation do
    label { Faker::Company.name + ' Library' }
    address { Faker::Address.street_address }
    phone_number { Faker::PhoneNumber.phone_number }
    contact_email { Faker::Internet.email }
    staff_only [true, false].sample
    library
  end

end
