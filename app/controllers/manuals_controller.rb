class ManualsController < ApplicationController
  before_action :set_manual, only: %i(show edit update destroy)
  before_action :set_completed_steps, only: :show
  before_action :set_manuals, only: :index
  before_action :set_tags
  load_and_authorize_resource

  def index
    respond_to do |format|
      format.html
      format.js { render partial: "manuals/more_manuals" }
      format.json { render json: @manuals }
    end
  end

  def show
    @comments = @manual.comments.includes(:user)
    @comment = Comment.new
    respond_to do |format|
      format.html
      format.json { render json: @manual, include: %i(steps tags) }
    end
  end

  def new
    @manual = Manual.new
    @category_id = params[:category_id] || Category.first.id
  end

  def create
    @manual = Manual.new(manual_params)
    @manual.user = current_user

    respond_to do |format|
      if @manual.save
        format.html { redirect_to edit_manual_path(@manual), notice: "Manual was successfully created." }
        format.json { render :show, status: :created, location: @manual }
      else
        format.html { redirect_to new_manual_path, flash: { error: @manual.errors.full_messages.join(", ") } }
        format.json { render json: @manual.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @manual.tag_list = params[:tags].map { |tag| tag[:name] }
    respond_to do |format|
      if @manual.update(manual_params)
        format.html { redirect_to @manual, notice: "Manual was successfully updated." }
        format.json { render :show, status: :ok, location: @manual }
      else
        format.html { render :edit }
        format.json { render json: @manual.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @manual.destroy
    respond_to do |format|
      format.html { redirect_to manuals_url, notice: "Manual was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_manual
    @manual = Manual.includes(:user).find(params[:id])
  end

  def set_tags
    @tags = Manual.includes(:user).tag_counts_on(:tags)
  end

  def set_manuals
    @manuals = if params[:tag]
                 Manual.tagged_with(params[:tag]).order(:id).page(params[:page])
               elsif params[:search]
                 Manual.search(params[:search]).page(params[:page])
               else
                 Manual.all.order(:id).page(params[:page])
               end
  end

  def set_completed_steps
    return if current_user.blank?
    @completed_steps = current_user.completed_steps.where(manual: @manual).map(&:step)
  end

  def manual_params
    params.require(:manual).permit(:name, :preview, :category_id, :tags)
  end
end
