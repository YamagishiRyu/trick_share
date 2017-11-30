class CommentsController < ApplicationController
  before_action :logged_in_contributer
  before_action :admin_user, only: :destroy

  def create
    @comment  = Comment.new(comment_params)
    @comment.contributor_id = current_contributor.id
    @comment.trick_id = params[:trick_id]
    if @comment.save
      flash[:success] = 'コメントが追加されました'
      redirect_to @comment.trick
    else
      flash[:danger] = 'コメントの内容がありません'
      redirect_to @comment.trick
    end
  end
  
  def destroy
    comment = Comment.find(params[:id])
    trick = comment.trick
    comment.destroy
    flash[:danger] = 'コメントは消去されました'
    redirect_to trick 
  end

  private
    def comment_params
     params.require(:comment).permit(:content) 
    end

    def admin_user
      redirect_to(root_url) unless current_contributor.admin?
    end
end
