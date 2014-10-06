github = Github.new client_id: '...', client_secret: '...'
github.authorize_url redirect_uri: 'http://localhost', scope: 'repo'