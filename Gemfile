source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

gem 'annotate'
gem 'bootsnap',             '>= 1.4.8', require: false
gem 'browser'
gem 'devise'
gem 'devise-i18n'
gem 'devise-i18n-views'
gem 'html2slim'
gem 'image_processing'
gem 'jbuilder',             '~> 2.10.1'
gem 'kaminari'
gem 'mini_magick'
gem 'mysql2',               '>= 0.5.3'
gem 'nokogiri',             '>= 1.11.0.rc4'
gem 'puma',                 '~> 4.3.11'
gem 'parser',               '2.7.0.1'
gem 'rails',                '~> 6.0.3.6'
gem 'rails-i18n'
gem 'ransack'
gem 'sass-rails',           '>= 6'
gem 'slim-rails'
gem 'turbolinks',           '~> 5.2.1'
gem 'webpacker',            '~> 4.3.0'
gem 'websocket-extensions', '>= 0.1.5'
gem 'aws-sdk-s3',           require: false

group :development, :test do
  gem 'byebug',              platforms: [:mri, :mingw, :x64_mingw]
  gem 'capistrano',          '3.14.0'
  gem 'capistrano-bundler'
  gem 'capistrano-rails'
  gem 'capistrano-rbenv'
  gem 'factory_bot_rails'
  gem 'rspec-rails'
  gem 'rubocop',             require: false
  gem 'rubocop-rails',       require: false
end

group :development do
  gem 'foreman'
  gem 'listen',                '~> 3.2'
  gem 'pry-byebug'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console',           '>= 4.0.4'
end

group :test do
  gem 'capybara'
  gem 'rails-controller-testing'
  gem 'webdrivers'
end

group :production, :staging do
  gem 'unicorn', '~> 5.5.5'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]