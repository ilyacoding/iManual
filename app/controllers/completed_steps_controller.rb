class CompletedStepsController < ApplicationController
  before_action :set_completed_step, only: [:show, :edit, :update, :destroy]

  # GET /completed_steps
  # GET /completed_steps.json
  def index
    @completed_steps = CompletedStep.all
  end

  # GET /completed_steps/1
  # GET /completed_steps/1.json
  def show
  end

  # GET /completed_steps/new
  def new
    @completed_step = CompletedStep.new
  end

  # GET /completed_steps/1/edit
  def edit
  end

  # POST /completed_steps
  # POST /completed_steps.json
  def create
    @completed_step = CompletedStep.new(completed_step_params)

    respond_to do |format|
      if @completed_step.save
        format.html { redirect_to @completed_step, notice: 'Completed step was successfully created.' }
        format.json { render :show, status: :created, location: @completed_step }
      else
        format.html { render :new }
        format.json { render json: @completed_step.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /completed_steps/1
  # PATCH/PUT /completed_steps/1.json
  def update
    respond_to do |format|
      if @completed_step.update(completed_step_params)
        format.html { redirect_to @completed_step, notice: 'Completed step was successfully updated.' }
        format.json { render :show, status: :ok, location: @completed_step }
      else
        format.html { render :edit }
        format.json { render json: @completed_step.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /completed_steps/1
  # DELETE /completed_steps/1.json
  def destroy
    @completed_step.destroy
    respond_to do |format|
      format.html { redirect_to completed_steps_url, notice: 'Completed step was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_completed_step
      @completed_step = CompletedStep.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def completed_step_params
      params.require(:completed_step).permit(:completed_manual_id, :step_id, :user_id)
    end
end
