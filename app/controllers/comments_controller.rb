class CommentsController < ApplicationController
  before_action :set_comment, only: [:destroy]
  load_and_authorize_resource

  # GET /manuals/:manual_id/new
  def new
    @comment = Comment.new
  end

  # POST /manuals/:manual_id/comments
  # POST /manuals/:manual_id/comments.json
  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.save
  end

  # DELETE /manuals/:manual_id/comments/1
  # DELETE /manuals/:manual_id/comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to manual_path(params[:manual_id]), notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content, :manual_id)
  end
end