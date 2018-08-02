require 'spec_helper'

describe 'Itinerary homepage', type: :feature do
  scenario 'Creating a new itinerary' do
    visit '/'

    click_on 'New itinerary'
    fill_in 'name', with: 'London'
    click_on 'Save'

    expect(page).to have_content 'London'

    click_on 'New itinerary'
    fill_in 'name', with: 'London'
    click_on 'Save'

    expect(page).to have_content 'London', count: 1

    accept_confirm { click_on 'Delete' }

    expect(page).to_not have_content 'London'
  end
end
