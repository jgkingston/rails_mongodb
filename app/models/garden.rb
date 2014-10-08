class Garden
  include Mongoid::Document

  embedded_in :user
  embeds_many :growth_rings
  
  field :owner, type: String
  field :name, type: String
  field :language, type: String
  # field :sha_keys, type: Array
  field :forks, type: Integer, default: 0
  field :contributors, type: Integer, default: 0
  field :sha_key_dates, type: Hash, default: {}
  field :messages, type: Hash, default: {}
  field :last_updated, type: DateTime, default: "2008-04-01T00:00:00Z"

  def safe_name

    self.name.gsub(/[.]/, '-')

  end

  def age
    
    Math.log2(self.messages.length).round

  end

  def get_length
    length = 130
    if self.growth_rings.length > 0
      length = self.median_commit
    end
    length
  end

  def median_commit
    changes = self.growth_rings.map{ |ring| ring["total"]}
    changes.sort!
    if changes.length.even?
      mid1 = changes[ ( changes.length / 2 ) - 1 ]
      mid2 = changes[ ( changes.length / 2 )     ]
      median = (mid1 + mid2) / 2
    else
      median = changes[ ( changes.length - 1 ) / 2 ]
    end
    length = Math.log2(median).round * 20
  end

  def comment_quality
    
    messages_lengths = self.messages.map{ |k, v| v.length }
    avg_message_length =  messages_lengths.reduce(:+) / self.messages.length
    gnarling = avg_message_length / 50.0

  end

  def age_descriptor
    case self.age
    when 0
      "a seedling"
    when 1
      "a sapling"
    when 2
      "a very young tree"
    when 3
      "a young tree"
    when 4
      "a younger tree"
    when 5
      "a tree of middling size"
    when 6
      "a substantial tree"
    when 7
      "a mature tree"
    when 8
      "an established tree"
    when 9
      "a well-established tree"
    when 10
      "a very well-established tree"
    end

  end

  def contributors_text
    if self.contributors == 1
      "One person has"
    else
      "#{self.contributors} people have"
    end  
  end

  def comment_comparator
    if self.comment_quality < 0.9
      ", on average, shorter than 50 characters"
    elsif self.comment_quality >= 0.9 && self.comment_quality <= 1.1
      "close to 50 characters"
    else
      ", on average, longer than 50 characters"
    end
  end

  def last_update
    if self.last_updated == "2008-04-01T00:00:00Z"
      "has not been watered"
    else
      "was last watered on #{self.last_updated.strftime("%m/%d/%Y")} at #{self.last_updated.strftime("%l:%M %p")}"
    end
  end

  def classify_tree

    numeric_classification = 0

    if self.contributors > 0
      numeric_classification = Math.log10(self.contributors).round
    end

    case numeric_classification
    when 0
      classification = "pine"
    when 1..10
      classification = "oak"
    end

    classification

  end

end
