module Admin
  class IterationsController < BaseController
    def index
      @iterations = project.iterations.done
    end

    def update
      project.update(project_params)
      project.update_iterations_from(iteration)

      redirect_to project
    end

    private

    def iteration
      @iteration ||= project.iterations.find(params[:id])
    end

    def project
      @project ||= current_user.projects.find(params[:project_id])
    end

    def project_params
      params.require(:project).permit(:iteration_duration_in_weeks)
    end
  end
end
