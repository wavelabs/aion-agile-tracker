require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'database_cleaner'

DatabaseCleaner.strategy = :transaction
DatabaseCleaner.clean_with(:truncation)
Rake::Task['db:seed'].invoke

class ActiveSupport::TestCase
  include FactoryGirl::Syntax::Methods

  def setup
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
  end
end

class Minitest::Spec
  include FactoryGirl::Syntax::Methods

  class << self
    alias_method :context, :describe
  end

  before do
    DatabaseCleaner.start
  end

  after do
    DatabaseCleaner.clean
  end
end
