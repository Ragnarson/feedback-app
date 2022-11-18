module Seed
  module_function

  def seeds_path
    Rails.root.join("db", "seeds")
  end

  def load_seed(path)
    path += ".yml" unless path.ends_with? ".yml"
    YAML.safe_load(seeds_path.join(path).read, permitted_classes: [Symbol], permitted_symbols: [], aliases: true)
  end
end