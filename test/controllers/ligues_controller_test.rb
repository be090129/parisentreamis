require 'test_helper'

class LiguesControllerTest < ActionController::TestCase
  setup do
    @ligue = ligues(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ligues)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ligue" do
    assert_difference('Ligue.count') do
      post :create, ligue: { name: @ligue.name, owner_id: @ligue.owner_id }
    end

    assert_redirected_to ligue_path(assigns(:ligue))
  end

  test "should show ligue" do
    get :show, id: @ligue
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ligue
    assert_response :success
  end

  test "should update ligue" do
    patch :update, id: @ligue, ligue: { name: @ligue.name, owner_id: @ligue.owner_id }
    assert_redirected_to ligue_path(assigns(:ligue))
  end

  test "should destroy ligue" do
    assert_difference('Ligue.count', -1) do
      delete :destroy, id: @ligue
    end

    assert_redirected_to ligues_path
  end
end
