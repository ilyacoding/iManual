source "https://rubygems.org"
source "https://rails-assets.org"

ruby "2.4.0"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "rails", "~> 5.1.2"
gem "mysql2", ">= 0.3.18", "< 0.5"
gem "puma", "~> 3.7"
gem "sass-rails", "~> 5.0"
gem "uglifier", ">= 1.3.0"
gem "webpacker"
gem "therubyracer", platforms: :ruby

gem "coffee-rails", "~> 4.2"
gem "jbuilder", "~> 2.5"
gem "redis", "~> 3.2"

# Bootstrap
gem "sprockets-helpers"
gem "twitter-bootstrap-rails"

# JQuery
gem "jquery-rails"
gem "jquery-ui-rails"
gem "jquery-infinite-pages"
gem "rails-jquery-autocomplete"

# Angular
gem "angularjs-rails"
gem "rails-angular-ui-sortable"

# Style
gem "bootstrap-tagsinput-rails"

# Helpers
gem "redcarpet"
gem "local_time"
gem "acts-as-taggable-on", github: "mbleigh/acts-as-taggable-on"
gem "kaminari"

# Authorization
gem "devise"
gem "rolify"
gem "cancancan"
gem "devise-bootstrap-views"
gem "omniauth"
gem "omniauth-facebook"
gem "omniauth-twitter"
gem "omniauth-google-oauth2"
gem "omniauth-vk"

# Core
gem "ratyrate"
gem "gravtastic"
gem "russian", "~> 0.6.0"

# Search
gem "search_cop"

group :development, :test do
  # Call "byebug" anywhere in the code to stop execution and get a debugger console
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem "capybara", "~> 2.13"
  gem "selenium-webdriver"
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem "web-console", ">= 3.3.0"
  gem "listen", ">= 3.0.5", "< 3.2"
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "pry-byebug"
  gem "rubocop"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
