# == Schema Information
#
# Table name: tasks
#
#  id           :integer          not null, primary key
#  project_id   :integer
#  user_id      :integer
#  worked       :float
#  billed       :float
#  description  :text
#  date_started :date
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_tasks_on_project_id  (project_id)
#  index_tasks_on_user_id     (user_id)
#

class Task < ApplicationRecord
  belongs_to :project
  delegate :name, to: :project, prefix: true
  belongs_to :user
  delegate :email, to: :user, prefix: true
end
