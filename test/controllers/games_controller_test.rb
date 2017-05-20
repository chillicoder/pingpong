require 'test_helper'

class GamesControllerTest < ActionController::TestCase
  setup do
    user = users(:default)
    sign_in user

    @game = games(:win)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:games)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create game" do
    assert_difference('Game.count') do
      post :create, game: { date_played_at: @game.date_played_at, opponent_id: @game.opponent_id, their_score: @game.their_score, user_id: @game.user_id, your_score: @game.your_score }
    end

    assert_redirected_to root_path
  end
end
