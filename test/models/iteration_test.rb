# == Schema Information
#
# Table name: iterations
#
#  id         :integer          not null, primary key
#  start_date :date
#  end_date   :date
#  project_id :integer
#  velocity   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  number     :integer
#
# Indexes
#
#  index_iterations_on_project_id  (project_id)
#

require 'test_helper'

class IterationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
