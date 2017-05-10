require 'test_helper'

describe NewCompanyBuilder do
  let(:company_name) { 'Kairos Corp.' }
  let(:user)        { build(:user) }

  subject { NewCompanyBuilder.new }

  describe '.add_user' do
    before { subject.add_user(user) }

    it 'assigns the admin user' do
      assert_includes subject.build.users, user
    end
  end

  describe '.assign_attributes' do
    before { subject.assign_attributes(name: company_name) }

    it 'assigns the attributes' do
      assert_equal company_name, subject.build.name
    end
  end
end
