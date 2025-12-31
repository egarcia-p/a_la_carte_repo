FROM ruby:3.3.0

# Install system dependencies
RUN apt-get update -qq && apt-get install -y \
    nodejs \
    npm \
    postgresql-client \
    && rm -rf /var/lib/apt/lists/*

# Install Yarn
RUN npm install -g yarn

# Set working directory
WORKDIR /app

# Copy Gemfile and Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Install Gems
RUN bundle install

# Copy the rest of the application
COPY . .

# Expose port 3300
EXPOSE 3300

# Entry
RUN chmod +x /app/entrypoint.sh
ENTRYPOINT ["/app/entrypoint.sh"]


# Start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0", "-p", "3300"]
