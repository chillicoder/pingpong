class RankingsController < ApplicationController
  def index
    @users = User.order({rank: :asc, score: :desc}).all
  end
end
