require 'test_helper'

class StoryTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @story_type = story_types(:one)
  end

  test "should get index" do
    get story_types_url
    assert_response :success
  end

  test "should get new" do
    get new_story_type_url
    assert_response :success
  end

  test "should create story_type" do
    assert_difference('StoryType.count') do
      post story_types_url, params: { story_type: { display_name: @story_type.display_name, icon: @story_type.icon, name: @story_type.name } }
    end

    assert_redirected_to story_type_url(StoryType.last)
  end

  test "should show story_type" do
    get story_type_url(@story_type)
    assert_response :success
  end

  test "should get edit" do
    get edit_story_type_url(@story_type)
    assert_response :success
  end

  test "should update story_type" do
    patch story_type_url(@story_type), params: { story_type: { display_name: @story_type.display_name, icon: @story_type.icon, name: @story_type.name } }
    assert_redirected_to story_type_url(@story_type)
  end

  test "should destroy story_type" do
    assert_difference('StoryType.count', -1) do
      delete story_type_url(@story_type)
    end

    assert_redirected_to story_types_url
  end
end
