class CommentsController < ApplicationController
  before_action :set_comment, only: [:show]

  # GET /manuals/1
  # GET /manuals/1.json
  def show
    respond_to do |format|
      format.html
      format.json { render json: @comment }
    end
  end

  # GET /manuals/new
  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id

    respond_to do |format|
      if @comment.save
        # format.html { redirect_to manual_path(@comment.manual), notice: 'Comment was successfully added.' }
        # format.json { render :show, status: :created }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_comment

  end

  def comment_params
    params.require(:comment).permit(:content, :manual_id)
  end
end