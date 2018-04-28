module BroadcastStories
  extend ActiveSupport::Concern

  included do
    def broadcast_story_update
      @project            = @story.project
      project_row_html    = render_to_string('admin/projects/_story', locals: {story: @story}, layout: false, formats: :html)

      ActionCable.server.broadcast "projects_channel",
        action: 'STORY_UPDATED',
        story: @story.as_json,
        changes: @story.previous_changes,
        project_row_html: project_row_html
    end

    def broadcast_story_create
      iteration_card_html = render_to_string('admin/projects/_iteration', locals: {iteration: @story.iteration}, layout: false)
      project_row_html    = render_to_string('admin/projects/_story', locals: {story: @story}, layout: false)

      ActionCable.server.broadcast "projects_channel",
        action: 'STORY_CREATED',
        story: @story.as_json,
        project_row_html: project_row_html,
        iteration_card_html: iteration_card_html
    end

    def broadcast_story_destroy(story)
      ActionCable.server.broadcast 'projects_channel',
        action: 'STORY_DESTROYED',
        story_id: story.id
    end

    def broadcast_story_positions(project)
      ActionCable.server.broadcast 'projects_channel',
        action:    'POSITIONS_UPDATED',
        project: project
    end
  end
end
