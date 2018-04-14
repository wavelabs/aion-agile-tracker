module Admin
  class EstimationsController < ApplicationController
    def update
      project = Project.find(params[:project_id])
      story   = project.stories.find(params[:id])
      story.update(points: params[:points])
      redirect_to project
    end
  end
end
