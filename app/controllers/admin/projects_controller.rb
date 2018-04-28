module Admin
  class ProjectsController < BaseController
    before_action :set_project, only: [:show, :edit, :update, :destroy]
    before_action :set_accounts, only: [:new, :create, :edit, :update]

    # GET /projects/1
    def show
      @active_iterations = @project.active_iterations.includes(stories: [:requester, :owners, :labels])
    end

    # GET /projects/new
    def new
      @project = Project.new
    end

    # GET /projects/1/edit
    def edit
    end

    # POST /projects
    def create
      @project = Project.new(project_params)
      return render(:new) unless @project.save
      redirect_to @project, notice: 'Project was successfully created.'
    end

    # PATCH/PUT /projects/1
    def update
      if @project.update(project_params)
        redirect_to @project, notice: 'Project was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /projects/1
    def destroy
      @project.destroy
      redirect_to dashboard_url, notice: 'Project was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_project
        @project = Project.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def project_params
        params.require(:project).permit(:name, :description, :account_id)
      end

      def set_accounts
        @accounts = current_user.accounts.pluck(:name, :id)
      end
  end
end
