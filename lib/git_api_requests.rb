class GitHubApiRequest

  attr_accessor :username
  attr_accessor :repository
  attr_accessor :repositories
  attr_accessor :commits
  attr_accessor :sha
  attr_accessor :detailed_commits
  attr_accessor :single_commit
  attr_accessor :dev_token
  attr_accessor :base_url
  attr_accessor :stats

  def initialize
    self.base_url = "https://api.github.com/repos/"
    self.username = ""
    self.repository = ""
    self.repositories = []
    self.commits = []
    self.sha = ""
    self.detailed_commits = []
    self.single_commit = {}
    self.dev_token = "12898f0c3b6b2c07372f35cf9769350fe10c8a2e"
    self.stats
  end

  def get_repo

    url = "https://api.github.com/repos/" + self.username + "/" + self.repository

    ret = HTTParty.get url, headers: { "User-Agent" => self.username, "Authorization" => "token #{self.dev_token}" }

    ret

  end


  def get_repos

    url = "https://api.github.com/users/" + self.username + "/repos"

    ret = HTTParty.get url, headers: { "User-Agent" => self.username, "Authorization" => "token #{self.dev_token}" }

    puts ret

    self.repositories = ret.parsed_response

  end

  def get_commits

    url = "https://api.github.com/repos/" + self.username + "/" + self.repository + "/commits"

    ret = HTTParty.get url, headers: {"User-Agent" => self.username, "Authorization" => "token #{self.dev_token}"  }

    self.commits = ret.parsed_response

  end

  def get_commit sha
    
    url = "https://api.github.com/repos/" + self.username + "/" + self.repository + "/commits/" + sha

    ret = HTTParty.get url, headers: {"User-Agent" => self.username, "Authorization" => "token #{self.dev_token}"  }

    self.single_commit = ret.parsed_response

  end

  def get_stats

    url = "https://api.github.com/repos/" + self.username + "/" + self.repository + "/stats/contributors"

    puts url

    ret = HTTParty.get url, headers: {"User-Agent" => self.username, "Authorization" => "token #{self.dev_token}"  }

    p ret

    ret
    
  end

  def get_detailed_commits sha_key_dates_hash, last_growth_date_time
    
    new_commit_pairs = sha_key_dates_hash.select{ |k,v| v > last_growth_date_time}

    sha_keys = new_commit_pairs.keys

    sha_keys.each do |sha|
      url = "https://api.github.com/repos/" + self.username + "/" + self.repository + "/commits/" + sha

      ret = HTTParty.get url, headers: {"User-Agent" => self.username, "Authorization" => "token #{self.dev_token}"  }

      self.detailed_commits << ret.parsed_response
    end

  end

  def extract_commit_stats

    commit = self.single_commit

    stats = {total: commit["stats"]["total"], additions: commit["stats"]["additions"], deletions: commit["stats"]["deletions"], message: commit["commit"]["message"]}

    stats

  end

end