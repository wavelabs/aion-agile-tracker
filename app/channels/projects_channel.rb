class ProjectsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "projects_channel"
  end
end
