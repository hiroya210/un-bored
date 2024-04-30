class UsersController < ApplicationController
  skip_before_action :authenticate_user!

  def update
    @current_user = User.find(params[:id])
    @current_user.nickname = params[:user][:nickname]
    flash[:alert] = "Nickname cannot be empty" unless @current_user.save
    redirect_to games_path
  end
end
