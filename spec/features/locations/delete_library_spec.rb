require 'spec_helper'

feature 'Javascript delete location confirmation dialog', type: :feature, js: true do
  before :all do
    FactoryGirl.create(:library)
  end

  scenario 'User can delete library from index listing view' do
    visit libraries_path
    click_link 'Destroy'
    page.driver.browser.switch_to.alert.accept
    assert has_no_link? 'Destroy'
  end  

end
