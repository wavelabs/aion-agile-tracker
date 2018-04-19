source 'https://rubygems.org'

ruby '2.4.0'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.0'
gem 'pg'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'devise', git: 'https://github.com/plataformatec/devise.git', branch: 'master'
gem 'devise_invitable', '~> 1.7.0'
gem 'figaro'
gem 'redcarpet'
gem 'acts-as-taggable-on'
gem 'acts_as_commentable'
gem 'ransack', '~> 1.8', '>= 1.8.8'
gem 'aasm', '~> 4.12', '>= 4.12.3'
gem 'acts_as_list'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara', '~> 2.13.0'
  gem 'selenium-webdriver'
  gem 'factory_girl_rails'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'annotate'
end

group :test do
  gem 'database_cleaner'
  gem 'minitest-around'
  gem 'minitest', '5.10.1'
  gem 'simplecov', require: false
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
