source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "bcrypt-ruby", "3.1.5", :require => "bcrypt"
gem "bootstrap-sass", '~> 3.3.6'
gem "bootstrap-will_paginate", "~> 1.0"
gem "carrierwave"
gem "coffee-rails", "~> 4.2"
gem "config"
gem "devise"
gem "dropzonejs-rails"
gem "faker", "1.7.3"
gem "jbuilder", "~> 2.5"
gem "mini_magick"
gem "mysql2"
gem "puma", "~> 3.7"
gem "rails", "~> 5.1.1"
gem "remotipart", github: "mshibuya/remotipart"
gem "sass-rails"
gem "turbolinks"
gem "uglifier", ">= 1.3.0"
gem "font-awesome-sass"

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "capybara", "~> 2.13"
  gem "selenium-webdriver"
  gem "rails-controller-testing", "1.0.2"
  gem "minitest-reporters",       "1.1.14"
  gem "guard",                    "2.13.0"
  gem "guard-minitest",           "2.4.4"  
end

group :development do
  gem "web-console", ">= 3.3.0"
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "pry-rails"
end

group :production do
  gem "pg"
end

group :test do
  gem "rubocop"
  gem "rubocop-checkstyle_formatter"
  gem "saddler"
  gem "saddler-reporter-github"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
