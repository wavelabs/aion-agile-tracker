class StoryStatesController < ApplicationController
  before_action :set_story_state, only: [:show, :edit, :update, :destroy]

  # GET /story_states
  def index
    @story_states = StoryState.all
  end

  # GET /story_states/1
  def show
  end

  # GET /story_states/new
  def new
    @story_state = StoryState.new
  end

  # GET /story_states/1/edit
  def edit
  end

  # POST /story_states
  def create
    @story_state = StoryState.new(story_state_params)

    if @story_state.save
      redirect_to @story_state, notice: 'Story state was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /story_states/1
  def update
    if @story_state.update(story_state_params)
      redirect_to @story_state, notice: 'Story state was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /story_states/1
  def destroy
    @story_state.destroy
    redirect_to story_states_url, notice: 'Story state was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_story_state
      @story_state = StoryState.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def story_state_params
      params.require(:story_state).permit(:name, :display_name, :icon)
    end
end
