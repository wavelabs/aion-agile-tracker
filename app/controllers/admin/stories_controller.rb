module Admin
  class StoriesController < BaseController
    include BroadcastStories

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
      @story = Story.new(requester_id: current_user.id)
    end

    # GET /stories/1/edit
    def edit
    end

    # POST /stories
    def create
      @story = create_story

      if @story.save
        broadcast_story_create
        redirect_to @project, notice: 'Story was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /stories/1
    def update
      if @story.update(story_params)
        broadcast_story_update
        respond_to do |format|
          format.html { redirect_to @project, notice: 'Story was successfully updated.' }
          format.json { render json: 'OK' }
        end
      else
        respond_to do |format|
          format.html { render :edit }
          format.json { render json: @story.errors.full_messages, status: 422 }
        end
      end
    end

    # DELETE /stories/1
    def destroy
      @story.destroy
      broadcast_story_destroy(@story)
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
              .permit(:iteration_id, :position, :title, :description, :points,
                :requester_id, :story_type, :label_list, :release_date,
                owner_ids: [])

      end

      def create_params
        story_params.tap do |params|
          params[:project_id] = @project.id
        end
      end

      def set_project
        @project = current_user.projects.find params[:project_id]
      end

      def set_collaborators
        @collaborators = User.from_account(@project.account).pluck(:username, :id)
      end

      def create_story
        story           = @project.stories.build(create_params)
        story.iteration = @project.find_next_iteration_for_story(story)
        story
      end
  end

end
