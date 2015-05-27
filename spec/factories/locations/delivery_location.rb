require 'faker'

Faker::Config.locale = 'en-US'

FactoryGirl.define do

  factory :delivery_location, class: Locations::DeliveryLocation do
    label { Faker::Company.name + ' Library' }
    address { Faker::Address.street_address }
    phone_number { Faker::PhoneNumber.phone_number }
    contact_email { Faker::Internet.email }
    gfa_pickup { Faker::Lorem.characters(6) }
    staff_only [true, false].sample
    pickup_location [true, false].sample    
    library
  end

end
