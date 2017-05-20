class RankingsController < ApplicationController
  def index
    @users = User.order({rank: :desc, score: :desc}).all
  end
end
