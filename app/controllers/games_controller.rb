class GamesController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @current_user = current_or_guest_user
    @games = Game.all
  end
end
