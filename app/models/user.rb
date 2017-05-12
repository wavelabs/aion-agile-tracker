class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :companies_users, dependent: :destroy
  has_many :companies, through: :companies_users
  has_many :tasks

  attr_accessor :company_name

  def role_for(company)
    companies_users.find_by(company: company).role
  end
end
