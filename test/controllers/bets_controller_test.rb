require 'test_helper'

class BetsControllerTest < ActionController::TestCase
  setup do
    @bet = bets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bet" do
    assert_difference('Bet.count') do
      post :create, bet: { equipe1_id: @bet.equipe1_id, equipe2_id: @bet.equipe2_id, global_result_point: @bet.global_result_point, result_point: @bet.result_point, score1: @bet.score1, score2: @bet.score2, start_at: @bet.start_at }
    end

    assert_redirected_to bet_path(assigns(:bet))
  end

  test "should show bet" do
    get :show, id: @bet
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bet
    assert_response :success
  end

  test "should update bet" do
    patch :update, id: @bet, bet: { equipe1_id: @bet.equipe1_id, equipe2_id: @bet.equipe2_id, global_result_point: @bet.global_result_point, result_point: @bet.result_point, score1: @bet.score1, score2: @bet.score2, start_at: @bet.start_at }
    assert_redirected_to bet_path(assigns(:bet))
  end

  test "should destroy bet" do
    assert_difference('Bet.count', -1) do
      delete :destroy, id: @bet
    end

    assert_redirected_to bets_path
  end
end
