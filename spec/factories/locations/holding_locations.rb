require 'faker'

FactoryGirl.define do
  factory :holding_location, class: 'Locations::HoldingLocation' do
    ignore do
      library_args nil
    end
    label { Faker::Company.name + ' Library' }
    aeon_location [true, false].sample
    recap_electronic_delivery_location [true, false].sample
    open [true, false].sample
    requestable [true, false].sample
    always_requestable [true, false].sample
    circulates [true, false].sample
    code
    library { build(:library, library_args) }
  end

  factory :holding_location_locator, class: 'Locations::HoldingLocation' do
    ignore do
      library_args nil
      hours_locations_args nil
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
    hours_location { build(:hours_location, hours_locations_args) }
  end

  factory :holding_location_stackmap, class: 'Locations::HoldingLocation' do
    ignore do
      library_args nil
    end
    label { 'Lewis Library' }
    aeon_location false
    recap_electronic_delivery_location false
    open true
    requestable false
    always_requestable false
    circulates true
    code 'sci'
    library { build(:library, library_args) }
  end

  factory :holding_location_stackmap_closed, class: 'Locations::HoldingLocation' do
    ignore do
      library_args nil
    end
    label { 'Lewis Library' }
    aeon_location false
    recap_electronic_delivery_location false
    open true
    requestable false
    always_requestable false
    circulates true
    code 'scilal'
    library { build(:library, library_args) }
  end

  factory :holding_location_title_locations, class: 'Locations::HoldingLocation' do
    ignore do
      library_args nil
    end
    label { 'Lewis Library' }
    aeon_location false
    recap_electronic_delivery_location false
    open true
    requestable false
    always_requestable false
    circulates true
    code 'sciss'
    library { build(:library, library_args) }
  end
end
