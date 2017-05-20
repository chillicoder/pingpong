class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy]

  # GET /games
  def index
    @games = current_user.games.order(date_played_at: :desc).all
  end

  # GET /games/1
  def show
    @opponent = User.where(id: @game.opponent_id).first
  end

  # GET /games/new
  def new
    @game = current_user.games.new
    @users = User.where('id not in ( ? )', current_user.id).all
  end

  # GET /games/1/edit
  def edit
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

  # PATCH/PUT /games/1
  def update
    if @game.update(game_params)
      redirect_to @game, notice: 'Game was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /games/1
  def destroy
    @game.destroy
    redirect_to games_url, notice: 'Game was successfully destroyed.'
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
