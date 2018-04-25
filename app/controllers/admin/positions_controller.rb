module Admin
  class PositionsController < BaseController
    include BroadcastStories

    def update
      project_params[:iterations_attributes].each do |iteration_params|
        iteration_params[:stories_attributes].each do |story_params|
          id = story_params.delete :id
          Story.where(id: id).update_all(story_params.to_h)
        end
      end

      broadcast_story_positions project_params
      render json: 'OK', status: 200
    end

    private

    def project
      @project ||= current_user.projects.find params[:project_id]
    end

    def project_params
      params.require(:project).permit(
        :id, iterations_attributes: [
          :id, stories_attributes: [:id, :iteration_id, :position]
        ])
    end
  end
end
