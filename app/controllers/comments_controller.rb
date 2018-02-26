class CommentsController < ApplicationController
  load_and_authorize_resource

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.save
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to manual_path(params[:manual_id]), notice: "Comment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :manual_id)
  end
end
