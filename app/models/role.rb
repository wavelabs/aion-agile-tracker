# == Schema Information
#
# Table name: roles
#
#  id           :integer          not null, primary key
#  name         :string
#  display_name :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Role < ApplicationRecord
  class << self
    def admin
      find_by(name: 'admin')
    end

    def user
      find_by(name: 'user')
    end
  end
end
