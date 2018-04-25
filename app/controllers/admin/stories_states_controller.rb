module Admin
  class StoriesStatesController < BaseController
    include BroadcastStories
    before_action :set_story

    rescue_from AASM::InvalidTransition do |e|
      redirect_to @story.project, notice: e.message
    end

    Story.aasm.events.map(&:name).each do |event|
      define_method event do
        @story.public_send("#{event}!", current_user)
        @story.move_to_top if @story.last_status? && !@story.release?
        broadcast_story_update
        redirect_back fallback_location: @story.project, notice: "The story has transitioned to #{event} successfully."
      end
    end

    private
      def set_story
        @story = Story.ransack(id_eq: params[:id], project_id_eq: params[:project_id]).result.first
      end
  end
end
