class GamesController < ApplicationController
  # GET /games
  def index
    @games = current_user.games.order(date_played_at: :desc).all
  end

  # GET /games/new
  def new
    @game = current_user.games.new
    @users = User.where('id not in ( ? )', current_user.id).all
  end

  # POST /games
  def create
    @game = current_user.games.new(game_params)

    if @game.save
      redirect_to root_path
    else
      @users = User.where('id not in ( ? )', current_user.id).all
      render :new
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = current_user.games.where(id: params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def game_params
      params.require(:game).permit(:date_played_at, :opponent_id, :your_score, :their_score, :user_id)
    end
end
