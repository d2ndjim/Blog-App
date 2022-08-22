require 'rails_helper'
RSpec.describe 'Posts index page', type: :feature do
  before :each do
    @user = User.create(name: 'Lilly', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Poland.')
    @user2 = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Poland.')
    @first_post = Post.create(author: @user, title: 'Hello', text: 'This is my first post')
    5.times do |_i|
      Comment.create(post: @first_post, author: @user2, text: 'Hi Lilly!')
    end
    visit user_posts_path(@user)
  end
  it 'displays User profile Picture' do
    expect(page).to have_content(@user.photo)
  end
  it 'display the User Name' do
    expect(page).to have_content(@user.name)
  end
  it 'displays number of posts' do
    expect(page).to have_content('Number of posts: 1')
  end
  it 'display the post title' do
    expect(page).to have_content(@first_post.title)
  end
  it 'display the post body' do
    expect(page).to have_content(@first_post.text)
  end
  it 'display the first comment on a post' do
    expect(page).to have_content('Hi Lilly!')
  end
  it 'display the how many comments' do
    expect(page).to have_content('Number of comments: 5')
  end
  it 'display the how many Likes' do
    expect(page).to have_content('Number of likes: 0')
  end
  it 'after clicking on a post, redirect on a post show page' do
    click_link(@first_post.title)
    expect(page).to have_content('Comment 5')
  end
end
