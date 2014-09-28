class GitHubApiRequest

  attr_accessor :username
  attr_accessor :repository
  attr_accessor :repositories
  attr_accessor :commits
  attr_accessor :sha
  attr_accessor :detailed_commits
  attr_accessor :single_commit
  attr_accessor :dev_token

  def initialize
    self.username = ""
    self.repository = ""
    self.repositories = []
    self.commits = []
    self.sha = ""
    self.detailed_commits = []
    self.single_commit = {}
    self.dev_token = "12898f0c3b6b2c07372f35cf9769350fe10c8a2e"
  end

  def get_repos

    url = "https://api.github.com/users/" + self.username + "/repos"

    ret = HTTParty.get url, headers: { "User-Agent" => self.username, "Authorization" => "token #{self.dev_token}" }

    puts ret

    self.repositories = ret.parsed_response

  end

  def get_commits

    url = "https://api.github.com/repos/" + self.username + "/" + self.repository + "/commits"

    # Add (data) parameter to funciton and add the following concatenated 'string' to limit commits api by date:
    # "?since=" + date.to_time.iso8601.to_s.slice!(0...-6) + "Z"

    puts url

    ret = HTTParty.get url, headers: {"User-Agent" => self.username }

    self.commits = ret.parsed_response

  end

  def get_commit sha
    
    url = "https://api.github.com/repos/" + self.username + "/" + self.repository + "/commits/" + sha

    ret = HTTParty.get url, headers: {"User-Agent" => self.username }

    self.single_commit = ret.parsed_response

  end

  # def get_detailed_commits sha_keys
    
  #   sha_keys.each do |sha|
  #     url = "https://api.github.com/repos/" + self.username + "/" + self.repository + "/commits/" + sha

  #     ret = HTTParty.get url, headers: {"User-Agent" => self.username }

  #     self.detailed_commits << ret.parsed_response
  #   end

  # end

  def get_detailed_commits sha_key_dates_hash, last_growth_date_time
    
    new_commit_pairs = sha_key_dates_hash.select{ |k,v| v > last_growth_date_time}

    sha_keys = new_commit_pairs.keys

    sha_keys.each do |sha|
      url = "https://api.github.com/repos/" + self.username + "/" + self.repository + "/commits/" + sha

      ret = HTTParty.get url, headers: {"User-Agent" => self.username }

      self.detailed_commits << ret.parsed_response
    end

  end

  def extract_commit_stats

    commit = self.single_commit

    stats = {total: commit["stats"]["total"], additions: commit["stats"]["additions"], deletions: commit["stats"]["deletions"], message: commit["commit"]["message"]}

    stats

  end

end