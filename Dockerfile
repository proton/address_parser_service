# Base image:
FROM ruby:2.4.2

# Install dependencies
RUN apt-get update -qq && apt-get install -y build-essential

# Set an environment variable where the Rails app is installed to inside of Docker image:
ENV APP_ROOT /var/www/app
RUN mkdir -p $APP_ROOT

# Set working directory, where the commands will be ran:
WORKDIR $APP_ROOT

# Gems:
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN gem install bundler
RUN bundle install

# Copy the main application.
COPY . .

EXPOSE 3000

# Run app
CMD RACK_ENV=production REDIS_HOST=redis bundle exec puma -C puma.rb