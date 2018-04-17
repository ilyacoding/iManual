class RaterController < ApplicationController
  def create
    return render json: false if user_signed_in?
    params[:klass].classify.constantize.find(params[:id]).rate(params[:score].to_f, current_user, params[:dimension])

    render json: true
  end
end
