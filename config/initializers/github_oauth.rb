config.before_configuration do
  env_file = File.join(Rails.root, 'config', 'api.yml')
  YAML.load(File.open(env_file)).each do |key, value|
    ENV[key.to_s] = value
  end if File.exists?(env_file)
end



if Rails.env.development?
  Rails.application.config.middleware.use OmniAuth::Builder do
    provider :github, 
    ENV["GITHUB_CLIENT_ID_DEV"],
    ENV["GITHUB_CLIENT_SECRET_DEV"], 
    scope: "repo"
  end
end

if Rails.env.production?
  Rails.application.config.middleware.use OmniAuth::Builder do
    provider :github, 
    ENV["GITHUB_CLIENT_ID"],
    ENV["GITHUB_CLIENT_SECRET"], 
    scope: "repo"
  end
end







