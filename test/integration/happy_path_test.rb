require 'test_helper'

class HappyPathTest < ActionDispatch::IntegrationTest
  setup do
    @admin_role = Role.find_or_create_by(name: 'admin')
    @user_role  = Role.find_or_create_by(name: 'user')
  end

  test 'from registration to accept your first feature story' do
    register_new_user
    invite_collaborators
    create_project
    create_feature_story
    estimate_story
    join_as_collaborator
    follow_up_to_accept
  end

  private

  attr_reader :user, :account, :project, :iteration, :story, :collaborator

  def account
    @account ||= user.accounts.first
  end

  def register_new_user
    get '/users/sign_up'
    assert_response :success

    post '/users', params: { user: {username: 'ezekielriva', email: 'info@wavelabs-studio.com', password: '123123123', passowrd_confirmation: '123123123'}  }
    assert_response :redirect
    follow_redirect!
    assert_response :success

    @user    = User.find_by(username: 'ezekielriva')
    @account = Account.find_by(name: 'ezekielriva')

    assert user
    assert account
  end

  def create_project
    project_attrs = { name: 'Sample', description: 'Description', account_id: account.id }

    get '/admin/projects/new'
    assert_response :success

    post '/admin/projects/', params: { project: project_attrs }
    assert_response :redirect
    follow_redirect!
    assert_response :success

    @project = Project.find_by(project_attrs)

    assert project
    assert account.projects.where(project_attrs).exists
    assert user.projects.where(project_attrs).exists
  end

  def create_feature_story
    story_params = { title: 'Title', description: 'Description', points: -1, requester_id: user.id, story_type: 'feature' }
    get "/admin/projects/#{project.id}/stories/new"
    assert_response :success

    post "/admin/projects/#{project.id}/stories", params: { story: story_params }
    assert_response :redirect
    follow_redirect!
    assert_response :success

    @iteration = project.active_iterations.first
    @story     = project.stories.find_by(story_params)

    assert iteration
    assert story
  end

  def estimate_story
    patch "/admin/projects/#{project.id}/stories/#{story.id}/estimate", params: { points: 3 }
    assert_response :redirect
    follow_redirect!
    assert_response :success

    assert_equal 3, story.reload.points
  end

  def follow_up_to_accept
    patch  "/admin/projects/#{project.id}/stories/#{story.id}/start"
    assert_response :redirect
    follow_redirect!
    assert_response :success

    assert_includes story.owners, collaborator

    patch  "/admin/projects/#{project.id}/stories/#{story.id}/finish"
    assert_response :redirect
    follow_redirect!
    assert_response :success

    patch  "/admin/projects/#{project.id}/stories/#{story.id}/deliver"
    assert_response :redirect
    follow_redirect!
    assert_response :success

    patch  "/admin/projects/#{project.id}/stories/#{story.id}/accept"
    assert_response :redirect
    follow_redirect!
    assert_response :success

    patch  "/admin/projects/#{project.id}/stories/#{story.id}/reject"
    assert_response :redirect
    follow_redirect!
    assert_response :success
  end

  def invite_collaborators
    get "/admin/accounts/#{account.id}/invitation/new"
    assert_response :success

    post "/admin/accounts/#{account.id}/invitation", params: { user: { email: 'sample@sample.com' } }
    assert_response :redirect
    follow_redirect!
    assert_response :success

    @collaborator = User.find_by(email: 'sample@sample.com' )
    assert_includes collaborator.accounts, account
    assert collaborator.accounts.find_by(name: 'sample@sample.com')
  end

  def join_as_collaborator
    @collaborator.update(username: 'Sample')
    sign_in collaborator
  end
end
