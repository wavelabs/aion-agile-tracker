require 'test_helper'

class StoryTasksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @story_task = story_tasks(:one)
  end

  test "should get index" do
    get story_tasks_url
    assert_response :success
  end

  test "should get new" do
    get new_story_task_url
    assert_response :success
  end

  test "should create story_task" do
    assert_difference('StoryTask.count') do
      post story_tasks_url, params: { story_task: { description: @story_task.description, done: @story_task.done } }
    end

    assert_redirected_to story_task_url(StoryTask.last)
  end

  test "should show story_task" do
    get story_task_url(@story_task)
    assert_response :success
  end

  test "should get edit" do
    get edit_story_task_url(@story_task)
    assert_response :success
  end

  test "should update story_task" do
    patch story_task_url(@story_task), params: { story_task: { description: @story_task.description, done: @story_task.done } }
    assert_redirected_to story_task_url(@story_task)
  end

  test "should destroy story_task" do
    assert_difference('StoryTask.count', -1) do
      delete story_task_url(@story_task)
    end

    assert_redirected_to story_tasks_url
  end
end
