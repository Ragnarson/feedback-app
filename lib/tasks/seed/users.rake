require "seed/user_creator"

logger = Logger.new($stdout)

namespace :seed do
  desc "Seed users"
  task users: :environment do
    logger.info "Creating sample users..."
    Seed::UserCreator.new.create_and_save_users
  end
end