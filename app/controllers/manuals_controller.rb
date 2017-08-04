class ManualsController < ApplicationController
  before_action :set_manual, only: [:show, :edit, :update, :destroy]
  before_action :set_steps, only: [:show]
  before_action :set_manuals, only: [:index]
  before_action :set_tags
  # skip_before_action :verify_authenticity_token
  load_and_authorize_resource

  # GET /manuals
  # GET /manuals.json
  def index
    add_breadcrumb "Manuals", manuals_path
    respond_to do |format|
      format.html
      format.js
      format.json { render json: @manuals }
    end
  end

  # GET /manuals/1
  # GET /manuals/1.json
  def show
    @comment = Comment.new
    respond_to do |format|
      format.html
      format.json { render json: @manual, include: [:steps, :tags] }
    end
  end

  # GET /manuals/new
  def new
    @manual = Manual.new
    @category_id = params[:category_id] || Category.first.id
  end

  # GET /manuals/1/edit
  def edit
  end

  # POST /manuals
  # POST /manuals.json
  def create
    @manual = Manual.new(manual_params)
    @manual.user = current_user

    respond_to do |format|
      if @manual.save
        format.html { redirect_to edit_manual_path(@manual), notice: 'Manual was successfully created.' }
        format.json { render :show, status: :created, location: @manual }
      else
        format.html { render :new }
        format.json { render json: @manual.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /manuals/1
  # PATCH/PUT /manuals/1.json
  def update
    @manual.tag_list = params[:tags].map { |tag| tag[:name] }
    respond_to do |format|
      if @manual.update(manual_params)
        format.html { redirect_to @manual, notice: 'Manual was successfully updated.' }
        format.json { render :show, status: :ok, location: @manual }
      else
        format.html { render :edit }
        format.json { render json: @manual.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /manuals/1
  # DELETE /manuals/1.json
  def destroy
    @manual.destroy
    respond_to do |format|
      format.html { redirect_to manuals_url, notice: 'Manual was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def set_tags
    @tags = Manual.tag_counts_on(:tags)
  end

  private

  def set_manual
    @manual = Manual.find(params[:id])
  end

  def set_manuals
    if params[:tag]
      @manuals = Manual.tagged_with(params[:tag]).order(:id).page params[:page]
    elsif params[:category]
      @manuals = Manual.where(category_id: params[:category]).order(:id).page params[:page]
    else
      @manuals = Manual.all.order(:id).page params[:page]
    end
  end

  def set_steps
    @steps = @manual.ordered_steps
  end

  def manual_params
    params.require(:manual).permit(:name, :preview, :category_id, :tags)
  end

  def manual
    Manual.find(params[:manual_id])
  end
end
