require 'faker'

FactoryGirl.define do

  factory :holding_location, class: 'Locations::HoldingLocation' do
    label { Faker::Company.name + ' Library'}
    aeon_location [true, false].sample
    recap_electronic_delivery_location [true, false].sample
    open [true, false].sample
    requestable [true, false].sample
    always_requestable [true, false].sample
    circulates [true, false].sample
    code
    library
  end

  factory :holding_location_locator, class: 'Locations::HoldingLocation' do
    ignore do
      library_args nil
    end
    label { 'Firestone Library' }
    aeon_location [true, false].sample
    recap_electronic_delivery_location [true, false].sample
    open [true, false].sample
    requestable [true, false].sample
    always_requestable [true, false].sample
    circulates [true, false].sample
    code 'f'
    library { build(:library, library_args) }
  end

  factory :holding_location_stackmap, class: 'Locations::HoldingLocation' do
    label { 'Lewis Library'}
    aeon_location false
    recap_electronic_delivery_location false
    open true
    requestable false
    always_requestable false
    circulates true
    code 'sci'
    library
  end

end
