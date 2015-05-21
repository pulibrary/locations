require 'faker'

FactoryGirl.define do

  factory :holding_location, class: 'Locations::HoldingLocation' do
    label { Faker::Company.name + ' Library'}
    is_aeon_location [true, false].sample
    is_recap_electronic_delivery_location [true, false].sample
    is_open [true, false].sample
    is_requestable [true, false].sample
    is_always_requestable [true, false].sample
    code
    library
  end

end
