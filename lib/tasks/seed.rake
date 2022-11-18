require "seed"

namespace :seed do
  desc "Runs users seeds"
  task all: %w[users]
end