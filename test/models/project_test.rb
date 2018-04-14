# == Schema Information
#
# Table name: projects
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  company_id  :integer
#
# Indexes
#
#  index_projects_on_company_id  (company_id)
#

require 'test_helper'

describe Project do
  describe '.find_next_iteration_for_story' do
    let(:project)   { create(:project) }
    let(:requester) { project.company.users.first }

    context 'when no iterations' do
      it 'build first iteration when no active iterations' do
        story   = Story.new
        iteration = project.find_next_iteration_for_story(story)

        assert_equal 1, project.iterations.size
        assert_equal Date.today.beginning_of_week, iteration.start_date
        assert_equal Date.today.end_of_week, iteration.end_date
      end
    end

    context 'when iterations' do
      before { project.build_first_iteration.save }

      context 'when story has no estimations' do
        it 'select first active iteration' do
          story           = build(:story, :unestimated, project: project)
          iteration       = project.find_next_iteration_for_story(story)

          assert_equal 1, project.iterations.size
        end
      end

      context 'when story has estimations' do
        let(:story) { build(:story, points: 10, project: project) }
        it 'select first active iteration that fits' do
          first_iteration = project.find_next_iteration_for_story story
          story.update(iteration: first_iteration)
          iteration       = project.find_next_iteration_for_story build(:story, points: 0, project: project)

          assert_equal 1, project.iterations.size
          assert_equal first_iteration, iteration
        end

        it 'it creates a new iteration when it does not fit on any of the estimations' do
          first_iteration = project.find_next_iteration_for_story story
          story.update(iteration: first_iteration)
          iteration       = project.find_next_iteration_for_story build(:story, points: 10, project: project)

          assert_equal 2, project.iterations.size
          assert first_iteration != iteration
          assert_equal first_iteration.start_date + 1.week, iteration.start_date
          assert_equal first_iteration.end_date + 1.week, iteration.end_date
        end
      end
    end
  end
end
