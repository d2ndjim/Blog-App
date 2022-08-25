class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments)
  end

  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.includes(comments: [:author]).find(params[:id])
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
        format.html do
          redirect_to user_posts_path(user_id: new_post.author.id), notice: 'Post was successfully created.'
        end
      else
        format.html { render :new, alert: 'Error in creating post' }
      end
    end
  end

  def api_show
    @post = Post.find(params[:id])
    @comments = @post.comments
    render json: { data: @comments }, status: :ok
  end

  def api_create
    @post = Post.find(params[:id])
    @comment = current_user.comments.new(
      text: comment_params,
      author_id: current_user.id,
      post_id: @post.id
    )
    render json: { data: @comment }, status: :ok
  end

  def destroy
    post = Post.find(params[:id])
    user = User.find(post.author_id)
    user.posts_counter -= 1
    post.destroy
    user.save
    flash[:success] = 'You have deleted this post!'
    redirect_to user_path(current_user.id)
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
