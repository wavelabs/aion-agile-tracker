module Admin
  class IterationsController < BaseController
    def update
      if iteration.update(iterations_param)
        notice = 'Iteration was successfully updated.'
      else
        notice = 'Unable to update iteration.'
      end

      redirect_to project
    end

    private

    def iteration
      @iteration ||= project.iterations.find(params[:id])
    end

    def project
      @project ||= current_user.projects.find(params[:project_id])
    end

    def iterations_param
      params.require(:iteration).permit(:velocity)
    end
  end
end
