class StoryTasksController < ApplicationController
  before_action :set_story_task, only: [:show, :edit, :update, :destroy]

  # GET /story_tasks
  def index
    @story_tasks = StoryTask.all
  end

  # GET /story_tasks/1
  def show
  end

  # GET /story_tasks/new
  def new
    @story_task = StoryTask.new
  end

  # GET /story_tasks/1/edit
  def edit
  end

  # POST /story_tasks
  def create
    @story_task = StoryTask.new(story_task_params)

    if @story_task.save
      redirect_to @story_task, notice: 'Story task was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /story_tasks/1
  def update
    if @story_task.update(story_task_params)
      redirect_to @story_task, notice: 'Story task was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /story_tasks/1
  def destroy
    @story_task.destroy
    redirect_to story_tasks_url, notice: 'Story task was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_story_task
      @story_task = StoryTask.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def story_task_params
      params.require(:story_task).permit(:description, :done)
    end
end
