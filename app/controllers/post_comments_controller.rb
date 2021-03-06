class PostCommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    # comment = PostComment.new(post_comment_params)
    # comment.user_id = current_user.id
    comment = current_user.post_comments.new(post_comment_params)
    comment.post_id = @post.id
    comment.save
  end

  def destroy
    PostComment.find_by(id: params[:id], post_id: params[:post_id]).destroy
    @post = Post.find(params[:post_id])
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
