class CommentsController < ApplicationController
  before_action :authenticate

  def create
    @comment = current_user.comments.new(comment_params)
    @comment.save
    if @comment.save
      redirect_back(fallback_location: @post, notice: 'コメントを投稿しました')
    else
      redirect_back(fallback_location: @post, notice: 'コメントの投稿に失敗しました')
    end
  end

  def destroy
    @comment = Comment.find_by(id: params[:id])
    if @comment.destroy
      redirect_back(fallback_location: @post, notice: 'コメントを削除しました')
    else
      redirect_back(fallback_location: @post, notice: 'コメントの削除に失敗しました')
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end
end
