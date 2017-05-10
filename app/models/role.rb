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
