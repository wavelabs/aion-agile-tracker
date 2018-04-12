# == Schema Information
#
# Table name: groups
#
#  id         :integer          not null, primary key
#  name       :string
#  project_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_groups_on_project_id  (project_id)
#

class Group < ApplicationRecord
  belongs_to :project

  has_many :stories
end
