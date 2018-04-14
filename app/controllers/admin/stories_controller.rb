module Admin
  class StoriesController < BaseController
    before_action :set_project
    before_action :set_story,                 only: [:show, :edit, :update, :destroy]
    before_action :set_pickable_requesters,   only: [:new, :edit, :create, :update]

    # GET /stories
    def index
      @stories = Story.ransack(params[:q]).result
    end

    # GET /stories/1
    def show
    end

    # GET /stories/new
    def new
      @story = Story.new
    end

    # GET /stories/1/edit
    def edit
    end

    # POST /stories
    def create
      @story = create_story

      if @story.save
        redirect_to @project, notice: 'Story was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /stories/1
    def update
      if @story.update(story_params)
        redirect_to @project, notice: 'Story was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /stories/1
    def destroy
      @story.destroy
      redirect_to @project, notice: 'Story was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_story
        @story = Story.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def story_params
        params.require(:story)
              .permit(:title, :description, :points, :requester_id, :story_type, :label_list)
              .tap { |params| params[:points] = 0 unless params[:story_type] == 'feature' }
      end

      def set_project
        @project = current_company.projects.find params[:project_id]
      end

      def set_pickable_requesters
        @requesters = current_company.users
      end

      def create_story
        story           = @project.stories.build(story_params)
        story.iteration = @project.find_next_iteration_for_story(story)
        story
      end
  end

end