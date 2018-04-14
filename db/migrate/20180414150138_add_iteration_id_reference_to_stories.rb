class AddIterationIdReferenceToStories < ActiveRecord::Migration[5.1]
  def change
    add_reference :stories, :iteration, index: true
  end
end
