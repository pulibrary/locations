# frozen_string_literal: true

require 'spec_helper'

feature 'Holding Location views link to other associated locations', type: :feature do
  let(:library) { FactoryGirl.create(:library) }
  let(:delivery_location) { FactoryGirl.create(:delivery_location) }
  let(:holding_location) { FactoryGirl.create(:holding_location) }
  let(:hours_location) { FactoryGirl.create(:hours_location) }

  scenario 'Link to library from library label rather than extra show link' do
    library
    visit libraries_path
    click_link library.label
  end

  scenario 'Link to hours location from hours location label rather than extra show link' do
    hours_location
    visit hours_locations_path
    click_link hours_location.label
  end

  scenario 'Link to holding location from holding location label rather than extra show link' do
    holding_location
    visit holding_locations_path
    click_link holding_location.code
  end

  scenario 'Link to delivery location from delivery location label rather than extra show link' do
    delivery_location
    visit delivery_locations_path
    click_link delivery_location.label
  end

  scenario 'User can link to library associated with holding location from show view' do
    visit holding_locations_path(holding_location)
    click_link holding_location.library.code
  end

  scenario 'User can link to library associated with delivery location from index view' do
    delivery_location
    visit delivery_locations_path
    click_link delivery_location.library.code
  end

  scenario 'User can link to library associated with delivery location from show view' do
    visit delivery_locations_path(delivery_location)
    click_link delivery_location.library.code
  end
end
