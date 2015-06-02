require 'spec_helper'

feature 'Javascript delete library confirmation dialog', type: :feature, js: true do
  before :all do
    FactoryGirl.create(:library)
  end

  scenario 'User can delete library from index listing view' do
    visit libraries_path
    click_link 'Destroy'
    assert has_no_link? 'Destroy'
  end  

end
