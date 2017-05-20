module Admin
  class CommentsController < BaseController
    before_action :set_project
    before_action :set_story

    def create
      @comment = NewCommentBuilder.new
                                  .set_user(current_user)
                                  .set_commentable(@story)
                                  .assign_attributes(comment_params)
                                  .build
      @comment.save!
      redirect_to ['', @project, @story], notice: 'Comment created succesfully'
    rescue ActiveRecord::RecordInvalid => e
      redirect_to ['', @project, @story], notice: "Coudn\'t create the comment: #{@comment.errors.full_message}"
    end

    def update
      @comment = @story.comments.find(params[:id])
      @comment.update!(comment_params)
      redirect_to ['', @project, @story], notice: 'Comment updated succesfully'
    rescue ActiveRecord::RecordInvalid => e
      redirect_to ['', @project, @story], notice: "Coudn\'t update the comment: #{@comment.errors.full_message}"
    end

    private

    def set_project
      @project = current_company.projects.find(params[:project_id])
    end

    def set_story
      @story = @project.stories.find(params[:story_id])
    end

    def comment_params
      params.require(:comment).permit(:comment)
    end
  end
end
