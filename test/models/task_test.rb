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

require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
