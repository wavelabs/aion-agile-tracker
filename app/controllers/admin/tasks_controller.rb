module Admin
  class TasksController < BaseController
    before_action :set_task, only: [:show, :edit, :update, :destroy]
    before_action :set_projects, only: [:new, :create, :edit, :update]

    # GET /tasks
    def index
      @tasks = Task.all
    end

    # GET /tasks/1
    def show
    end

    # GET /tasks/new
    def new
      @task = Task.new
    end

    # GET /tasks/1/edit
    def edit
    end

    # POST /tasks
    def create
      @task = current_user.tasks.build(task_params)

      if @task.save
        redirect_to @task, notice: 'Task was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /tasks/1
    def update
      if @task.update(task_params)
        redirect_to @task, notice: 'Task was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /tasks/1
    def destroy
      @task.destroy
      redirect_to tasks_url, notice: 'Task was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_task
        @task = Task.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def task_params
        params.require(:task).permit(:project_id, :user_id, :worked, :billed, :description, :date_started)
      end

      def set_projects
        @projects = current_user.projects
      end
  end

end
