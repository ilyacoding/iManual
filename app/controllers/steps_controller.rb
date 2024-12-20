class StepsController < ApplicationController
  before_action :set_show_step, only: [:show, :edit, :destroy]
  before_action :set_completed_attributes, only: [:show]
  load_resource :manual
  load_and_authorize_resource :step, through: :manual

  def index
    @steps = Step.all
    respond_to do |format|
      format.html
      format.json
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json { render json: @step, include: :blocks }
    end
  end

  def new
    @step = Step.new
  end

  def create
    @step = Step.new(step_params)
    @step.user_id = current_user.id
    @step.manual_id = params[:manual_id]

    respond_to do |format|
      if @step.save
        format.html { redirect_to @step, notice: 'Step was successfully created.' }
        format.json { render :show, status: :created }
      else
        format.html { render :new }
        format.json { render json: @step.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @step = Step.find(params[:id])
    respond_to do |format|
      if @step.update(step_params)
        format.html { redirect_to @step, notice: 'Step was successfully updated.' }
        format.json { render :show, status: :ok }
      else
        format.html { render :edit }
        format.json { render json: @step.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @step.destroy
    respond_to do |format|
      format.html { redirect_to steps_url, notice: 'Step was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_show_step
    @step = Step.where(manual_id: params[:manual_id]).where(priority: params[:id]).first
  end

  def set_completed_attributes
    return if current_user.blank?
    CompletedStep.where(user: current_user, manual: @step.manual, step: @step).first_or_create
  end

  def step_params
    params.require(:step).permit(:name, :priority)
  end
end
