
$github_api_info = YAML.load_file(
  Rails.root.join('config', 'api.yml')
  )[Rails.env]['github']


Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, 
  $github_api_info['client_id'], 
  $github_api_info['client_secret'], 
  scope: "repo"
end


