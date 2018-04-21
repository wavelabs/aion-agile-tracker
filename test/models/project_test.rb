# == Schema Information
#
# Table name: projects
#
#  id                          :integer          not null, primary key
#  name                        :string
#  description                 :text
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  account_id                  :integer
#  velocity                    :integer          default("10")
#  iteration_duration_in_weeks :integer          default("1")
#
# Indexes
#
#  index_projects_on_account_id  (account_id)
#

require 'test_helper'

describe Project do
  describe '.build_iteration_from_last_iteration' do
    context 'when no iterations' do
      it 'returns nil' do
        assert_nil build(:project).build_iteration_from_last_iteration
      end
    end

    context 'when iterations' do
      it 'builds the new iteration using velocity and dates from last' do
        project = create(:project, :with_active_iteration)
        iteration = project.build_iteration_from_last_iteration

        assert_equal (Date.today.beginning_of_week + 1.week), iteration.start_date
        assert_equal (Date.today.end_of_week + 1.week), iteration.end_date
        assert_equal 1, iteration.velocity
        assert_equal 2, iteration.number
      end
    end
  end

  describe '.build_first_iteration' do
    it 'builds first iteration' do
      project   = build(:project, velocity: 4, iteration_duration_in_weeks: 3)
      iteration = project.build_first_iteration

      expected_end_date = Date.today.beginning_of_week + 20.days

      assert_equal Date.today.beginning_of_week, iteration.start_date
      assert_equal expected_end_date, iteration.end_date
      assert_equal 4, iteration.velocity
      assert_equal 1, iteration.number
    end
  end
end
