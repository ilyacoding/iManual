class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :set_related, only: [:show]
  load_and_authorize_resource

  def index
    @users = User.all
  end

  def show
    respond_to do |format|
      format.html
      format.json {
        render json: @user, include: :manuals
      }
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @user.update_attributes(user_params)
        format.html { redirect_to @user, notice: 'User updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to root_url, notice: 'User was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :about, :interests)
  end

  def set_related
    @manuals = @user.manuals.includes(:category)
    @comments = @user.comments.includes(:user)
  end
end
