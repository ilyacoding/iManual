class StepsController < ApplicationController
  before_action :set_update_step, only: [:update]
  before_action :set_show_step, only: [:show, :edit, :destroy]
  before_action :set_blocks, only: [:show]
  before_action :set_completed_attributes, only: [:show]
  load_resource :manual
  load_and_authorize_resource :step, :through => :manual

  def index
    @steps = Step.all
    respond_to do |format|
      format.html
      format.json {
        render json: @steps
      }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json {
        render json: @step, include: :blocks
      }
    end
  end

  def new
    @step = Step.new
  end

  def edit
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

  def set_update_step
    @step = Step.find(params[:id])
  end

  def set_show_step
    @step = Step.where(manual_id: params[:manual_id]).where(priority: params[:id]).first
  end

  def set_blocks
    @blocks = @step.ordered_blocks
  end

  def set_completed_attributes
    if current_user.present?
      completed_manual = CompletedManual.where(user: current_user, manual: @step.manual).first_or_create
      completed_step = CompletedStep.where(user: current_user, completed_manual: completed_manual, step: @step)
                                    .first_or_create

      total_steps = @step.manual.steps.count
      completed_steps = completed_step.completed_manual.completed_steps.count

      completed_manual.update_attribute(:completed, :true) if total_steps == completed_steps
    end
  end

  def step_params
    params.require(:step).permit(:name, :priority)
  end
end
