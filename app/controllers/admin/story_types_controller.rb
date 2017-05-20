class StoryTypesController < ApplicationController
  before_action :set_story_type, only: [:show, :edit, :update, :destroy]

  # GET /story_types
  def index
    @story_types = StoryType.all
  end

  # GET /story_types/1
  def show
  end

  # GET /story_types/new
  def new
    @story_type = StoryType.new
  end

  # GET /story_types/1/edit
  def edit
  end

  # POST /story_types
  def create
    @story_type = StoryType.new(story_type_params)

    if @story_type.save
      redirect_to @story_type, notice: 'Story type was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /story_types/1
  def update
    if @story_type.update(story_type_params)
      redirect_to @story_type, notice: 'Story type was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /story_types/1
  def destroy
    @story_type.destroy
    redirect_to story_types_url, notice: 'Story type was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_story_type
      @story_type = StoryType.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def story_type_params
      params.require(:story_type).permit(:name, :display_name, :icon)
    end
end
