require "test_helper"

class UserQuestsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get user_quests_index_url
    assert_response :success
  end

  test "should get show" do
    get user_quests_show_url
    assert_response :success
  end

  test "should get create" do
    get user_quests_create_url
    assert_response :success
  end

  test "should get update" do
    get user_quests_update_url
    assert_response :success
  end

  test "should get destroy" do
    get user_quests_destroy_url
    assert_response :success
  end
end
