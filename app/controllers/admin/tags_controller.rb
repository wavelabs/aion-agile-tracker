module Admin
  class TagsController < BaseController
    def index
      project = Project.find(params[:project_id])
      labels    = project.labels.where('name LIKE ?', "%#{params[:name]}%")
      render json: labels, status: 200
    end
  end
end
