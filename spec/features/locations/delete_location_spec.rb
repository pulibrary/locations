require 'spec_helper'

feature 'Javascript delete location confirmation dialog', type: :feature, js: true do

  before :all do
    FactoryGirl.create(:holding_location)
    FactoryGirl.create(:delivery_location)
  end

  scenario 'User can delete holding location from index listing view' do
    visit holding_locations_path
    click_link 'Destroy'
    page.driver.browser.switch_to.alert.accept
    assert has_no_link? 'Destroy'
  end

  scenario 'User can delete delivery location from index listing view' do
    visit delivery_locations_path
    click_link 'Destroy'
    page.driver.browser.switch_to.alert.accept
    assert has_no_link? 'Destroy'
  end

end
