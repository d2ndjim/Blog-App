require 'rails_helper'

# Test the users index page using integration tests

RSpec.describe 'Users index page', type: :feature do
  before :each do
    user1 = User.create!(name: 'Lilly', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
    user2 = User.create!(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Poland.')
  end

  it 'displays all users' do
    visit root_path
    expect(page).to have_content('Lilly')
    expect(page).to have_content('Tom')
  end

  it 'displays all users profile photo' do
    visit '/'
    find('img[alt="Lilly"]')
    find('img[alt="Tom"]')
  end
end