class BlocksController < ApplicationController
  before_action :set_block, only: %i(show edit update destroy)
  load_resource :step
  load_and_authorize_resource :block, through: :step

  PERMITTED_PARAMS = %i(content priority step_id type priority)

  def index
    @blocks = Block.all
    respond_to do |format|
      format.html
      format.json { render json: @blocks }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json { render json: @block }
    end
  end

  def new
    @block = Block.new
  end

  def create
    @block = Block.new(block_params)
    @block.type = params[:type].capitalize

    respond_to do |format|
      if @block.save
        format.html { redirect_to @block, notice: "Block was successfully created." }
        format.json { render json: @block }
      else
        format.html { render :new }
        format.json { render json: @block.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @block.update(block_params)
        format.html { redirect_to @block, notice: "Block was successfully updated." }
        format.json { render json: @block }
      else
        format.html { render :edit }
        format.json { render json: @block.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @block.destroy
    respond_to do |format|
      format.html { redirect_to blocks_url, notice: "Block was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_block
    @block = Block.find(params[:id])
  end

  def block_params
    params.require(:block).permit(*PERMITTED_PARAMS)
  end
end
