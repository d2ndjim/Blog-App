class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    new_comment = current_user.comments.new(
      text: comment_params,
      author_id: current_user.id,
      post_id: @post.id
    )
    if new_comment.save
      redirect_to user_posts_path(user_id: new_comment.post_id), notice: 'Success!'
    else
      render :new, alert: 'Error Occurred'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)[:text]
  end
end
