require 'rails_helper'

RSpec.describe 'Test the User show page' do
  before :each do
    @user = User.create(name: 'Jake', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Algeria.')

    # add five posts for the user
    5.times do |i|
      Post.create!(author: @user, title: "Post #{i}", text: 'This is my new post')
    end
    visit user_path(@user.id)
  end

  it 'displays users profile picture' do
    expect(page).to have_content('https://unsplash.com/photos/F_-0BxGuVvo')
  end

  it 'displays the username' do
    expect(page).to have_content(@user.name)
  end

  it 'show number of posts written by the user' do
    expect(page).to have_content("Number of Posts: #{@user.posts_counter}")
  end

  it 'the users bio is visible' do
    expect(page).to have_content(@user.bio)
  end

  it 'only the first three posts is visible' do
    expect(page).to have_content('Post 4')
    expect(page).to have_content('Post 3')
    expect(page).to have_content('Post 2')
    expect(page).to_not have_content('Post 1')
  end

  it 'button to view all posts is visible' do
    expect(page).to have_content('See all posts')
  end

  it 'go to the users post#index page when a user click on view all post' do
    click_link 'See all posts'
    expect(page).to have_current_path user_posts_path(@user)
  end
end
