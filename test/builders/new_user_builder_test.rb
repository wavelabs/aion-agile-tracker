require 'test_helper'

describe NewUserBuilder do
  let(:company_name) { 'Kairos Corp.' }
  let(:user) { build(:user, company_name: company_name) }

  subject { NewUserBuilder.new(user) }

  describe '.add_company_relationship' do
    context 'when it is a new company' do
      before { subject.add_company_relationship }

      it 'creates the company' do
        assert Company.where(name: company_name).exists?
      end

      it 'assigns it to the user' do
        assert user.companies.where(name: company_name).exists?
      end
    end

    context 'when the company already exists' do
      before do
        Company.create(name: company_name)
        subject.add_company_relationship
      end

      it 'does not create a new company' do
        assert_equal 1, Company.count
      end

      it 'assigns it to the user' do
        assert user.companies.where(name: company_name).exists?
      end
    end
  end
end
