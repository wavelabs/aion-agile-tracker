class Task < ApplicationRecord
  belongs_to :project
  delegate :name, to: :project, prefix: true
  belongs_to :user
  delegate :email, to: :user, prefix: true
end
