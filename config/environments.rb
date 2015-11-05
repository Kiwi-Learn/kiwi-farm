configure :development, :test do
  ActiveRecord::Base.configurations = YAML.load_file('config/database.yml')
end
