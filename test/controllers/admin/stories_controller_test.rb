require 'test_helper'

class StoriesControllerTest < ActionDispatch::IntegrationTest
  test 'when creates a new storie the projects add it to the right iteration' do
    account = create :account, :with_admin
    admin   = account.admin
    project = create :project, :with_active_iteration, velocity: 1, active_iterations_count: 1, account: account

    sign_in admin

    post "/admin/projects/#{project.id}/stories", params: {story: attributes_for(:story, :feature, requester_id: admin.id) }
    assert_equal 2, project.active_iterations.count
    assert_equal 1, project.active_iterations.first.stories.count
    assert_equal 0, project.active_iterations.last.stories.count

    post "/admin/projects/#{project.id}/stories", params: {story: attributes_for(:story, :feature, requester_id: admin.id) }
    assert_equal 2, project.active_iterations.count
    project.active_iterations.each { |iteration| assert_equal 1, iteration.stories.count }

    post "/admin/projects/#{project.id}/stories", params: {story: attributes_for(:story, :feature, requester_id: admin.id) }
    assert_equal 3, project.active_iterations.count
    project.active_iterations.each { |iteration| assert_equal 1, iteration.stories.count }
  end
end
