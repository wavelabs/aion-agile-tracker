require 'test_helper'

describe FinishIteration do
  context 'when active iterations' do
    let(:project)           { create :project, :with_active_iteration }
    let(:current_iteration) { project.current_iteration }
    let(:done_iteration)    { create :iteration, project: project, number: 0, start_date: current_iteration.start_date - project.iteration_duration_in_weeks.week, end_date: current_iteration.end_date - project.iteration_duration_in_weeks.week }

    before do
      create :story, :estimated, :feature, :accepted, iteration: done_iteration, project: project, points: 5
      create :story, :estimated, :release, :accepted, iteration: done_iteration, project: project
      create :story, :estimated, :feature, iteration: done_iteration, project: project
      create :story, :estimated, :release, iteration: done_iteration, project: project
      create :story, :estimated, :feature, :delivered, iteration: done_iteration, project: project

      FinishIteration.call(done_iteration)
    end

    it 'keeps accepted stories to the current iteration' do
      assert_equal 2, done_iteration.stories.accepted.count
    end

    it 'moves unstarted stories but releases to the next iteration' do
      assert_equal 0, done_iteration.stories.unstarted.but_releases.count, 'Unstarted stories have been moved'
      assert_equal 2, done_iteration.stories.releases.count, 'Release story have been moved'
      assert_equal 1, current_iteration.stories.unstarted.count, 'Unstarted stories have not been moved'
    end

    it 'calculates final velocity' do
      assert_equal 5, done_iteration.reload.velocity
    end

    it 'moves all started stories but releases to the next iteration' do
      assert_equal 0, done_iteration.stories.not_accepted.but_releases.count, 'Not accepted stories have been moved'
      assert_equal 2, current_iteration.stories.not_accepted.but_releases.count, 'Not accepted stories but releases have not been moved'
    end

    it 'marks as rejected all unaccepted releases' do
      assert_equal 1, done_iteration.stories.releases.rejected.count, 'Releases have not been rejected'
    end
  end

  context 'when no active iteration' do
    let(:project)           { create :project }
    let(:done_iteration)    { create :iteration, project: project, number: 1, start_date: Date.today.beginning_of_week - project.iteration_duration_in_weeks.week, end_date: Date.today.end_of_week - project.iteration_duration_in_weeks.week }
    before { FinishIteration.call(done_iteration) }

    it 'creates one' do
      assert_equal 2, project.iterations.count
    end
  end
end
