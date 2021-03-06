class CommentsController < ApplicationController
  before_action :authenticate_user!, only: %i[create destroy]

  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      flash[:notice] = I18n.t('customs.resources.create', resource_name)
    else
      flash[:alert] = @comment.errors.full_messages[0]
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @comment = Comment.find_by_id(params[:id])
    if @comment.destroy
      flash[:notice] = I18n.t('customs.resources.destroy.success', resource_name)
    else
      flash[:alert] = I18n.t('customs.resources.destroy.failure', resource_name)
    end
    redirect_back(fallback_location: root_path)
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end

  def resource_name
    { resource: 'Comment' }
  end
end
