class Project < ApplicationRecord
  belongs_to :company
  has_many :tasks

  def worked
    tasks.sum(:worked)
  end

  def billed
    tasks.sum(:billed)
  end
end
