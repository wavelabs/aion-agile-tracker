module Admin
  class StoriesController < BaseController
    before_action :set_project
    before_action :set_story,                 only: [:show, :edit, :update, :destroy]
    before_action :set_collaborators,         only: [:new, :edit, :create, :update]

    # GET /stories
    def index
      @stories       = @project.stories.includes(:owners, :requester, :labels).ransack(params[:q]).result.order_by_weight
      @total_points  = @stories.features.sum(:points)
      @points_done   = @stories.features.accepted.sum(:points)
      @total_stories = @stories.count
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
              .permit(:title, :description, :points, :requester_id, :story_type, :label_list, owner_ids: [])
              .tap do |params|
                params[:points] = 0 unless params[:story_type] == 'feature'
                params[:project_id] = @project.id
              end
      end

      def set_project
        @project = current_user.projects.find params[:project_id]
      end

      def set_collaborators
        @collaborators = User.invitation_accepted.from_account(@project.account).pluck(:username, :id)
      end

      def create_story
        story           = @project.stories.build(story_params)
        story.iteration = @project.find_next_iteration_for_story(story)
        story
      end
  end

end
