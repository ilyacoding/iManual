class CompletedManualsController < ApplicationController
  before_action :set_completed_manual, only: [:show, :edit, :update, :destroy]

  # GET /completed_manuals
  # GET /completed_manuals.json
  def index
    @completed_manuals = CompletedManual.all
  end

  # GET /completed_manuals/1
  # GET /completed_manuals/1.json
  def show
  end

  # GET /completed_manuals/new
  def new
    @completed_manual = CompletedManual.new
  end

  # GET /completed_manuals/1/edit
  def edit
  end

  # POST /completed_manuals
  # POST /completed_manuals.json
  def create
    @completed_manual = CompletedManual.new(completed_manual_params)

    respond_to do |format|
      if @completed_manual.save
        format.html { redirect_to @completed_manual, notice: 'Completed manual was successfully created.' }
        format.json { render :show, status: :created, location: @completed_manual }
      else
        format.html { render :new }
        format.json { render json: @completed_manual.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /completed_manuals/1
  # PATCH/PUT /completed_manuals/1.json
  def update
    respond_to do |format|
      if @completed_manual.update(completed_manual_params)
        format.html { redirect_to @completed_manual, notice: 'Completed manual was successfully updated.' }
        format.json { render :show, status: :ok, location: @completed_manual }
      else
        format.html { render :edit }
        format.json { render json: @completed_manual.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /completed_manuals/1
  # DELETE /completed_manuals/1.json
  def destroy
    @completed_manual.destroy
    respond_to do |format|
      format.html { redirect_to completed_manuals_url, notice: 'Completed manual was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_completed_manual
      @completed_manual = CompletedManual.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def completed_manual_params
      params.require(:completed_manual).permit(:manual_id, :user_id)
    end
end
