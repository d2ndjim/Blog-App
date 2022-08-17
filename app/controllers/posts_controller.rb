class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.author
    @comments = @post.comments
  end

  def new
    @post = Post.new
  end

  def create
    new_post = current_user.posts.new(post_params)
    new_post.likes_counter = 0
    new_post.comments_counter = 0
    respond_to do |format|
      if new_post.save
        format.html { redirect_to "/users/#{new_post.author.id}/posts/", notice: 'Post was successfully created.' }
      else
        format.html { render :new, alert: 'Error in creating post' }
      end
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
