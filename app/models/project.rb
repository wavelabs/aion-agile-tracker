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

class Project < ApplicationRecord
  belongs_to :company
  has_many :stories
  has_many :story_states
end
