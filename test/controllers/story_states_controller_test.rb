require 'test_helper'

class StoryStatesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @story_state = story_states(:one)
  end

  test "should get index" do
    get story_states_url
    assert_response :success
  end

  test "should get new" do
    get new_story_state_url
    assert_response :success
  end

  test "should create story_state" do
    assert_difference('StoryState.count') do
      post story_states_url, params: { story_state: { display_name: @story_state.display_name, icon: @story_state.icon, name: @story_state.name } }
    end

    assert_redirected_to story_state_url(StoryState.last)
  end

  test "should show story_state" do
    get story_state_url(@story_state)
    assert_response :success
  end

  test "should get edit" do
    get edit_story_state_url(@story_state)
    assert_response :success
  end

  test "should update story_state" do
    patch story_state_url(@story_state), params: { story_state: { display_name: @story_state.display_name, icon: @story_state.icon, name: @story_state.name } }
    assert_redirected_to story_state_url(@story_state)
  end

  test "should destroy story_state" do
    assert_difference('StoryState.count', -1) do
      delete story_state_url(@story_state)
    end

    assert_redirected_to story_states_url
  end
end
