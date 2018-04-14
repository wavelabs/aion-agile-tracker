# == Schema Information
#
# Table name: owners_stories
#
#  id         :integer          not null, primary key
#  owner_id   :integer
#  story_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_owners_stories_on_story_id  (story_id)
#

class OwnersStory < ApplicationRecord
  belongs_to :owner, class_name: 'User'
  belongs_to :story

  validates :owner, uniqueness: { scope: :story }
end
