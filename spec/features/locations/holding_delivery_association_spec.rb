# frozen_string_literal: true

require 'spec_helper'

feature 'Holding Location Delivery Location Multiselect', type: :feature do
  let(:delivery_location) { FactoryGirl.create(:delivery_location, staff_only: false) }
  let(:holding_location) { FactoryGirl.create(:holding_location) }
  before { 5.times { FactoryGirl.create(:delivery_location) } }

  scenario 'Multiselect delivery locations persist' do
    visit edit_holding_location_path(holding_location)

    delivery_location_instances = [2, 3]
    delivery_location_instances.each do |i|
      check "holding_location_delivery_location_ids_#{i}"
    end

    click_button 'Update Holding location'

    visit edit_holding_location_path(holding_location)
    delivery_location_instances.each do |i|
      checkbox = find("#holding_location_delivery_location_ids_#{i}")
      expect(checkbox).to be_checked
    end
  end

  scenario 'Links to delivery locations from holding location' do
    delivery_location
    visit holding_location_path(holding_location)
    click_link delivery_location.label
  end
end
