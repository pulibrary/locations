require 'faker'

FactoryGirl.define do

  factory :holding_location, class: 'Locations::HoldingLocation' do
    label { Faker::Company.name + ' Library'}
    aeon_location [true, false].sample
    recap_electronic_delivery_location [true, false].sample
    open [true, false].sample
    requestable [true, false].sample
    always_requestable [true, false].sample
    code
    library
  end

end
