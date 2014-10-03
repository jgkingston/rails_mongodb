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

  def age
    age = 0
    if self.growth_rings.length > 0
      growth_rings = self.growth_rings.length
      age = Math.log2(growth_rings).round
    else
      age = Math.log2(self.messages.length).round
    end
    age
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
    messages = self.growth_rings.map{ |ring| ring["message"]}
    messages_lengths = messages.map{ |message| message.length }
    
    if self.growth_rings.length > 0
      messages = self.growth_rings.map{ |ring| ring["message"]}
      messages_lengths = messages.map{ |message| message.length }
      avg_message_length =  messages_lengths.reduce(:+) / messages.length
      gnarling = avg_message_length / 50.0
    else
      messages_lengths = self.messages.map{ |k, v| v.length }
      avg_message_length =  messages_lengths.reduce(:+) / self.messages.length
      gnarling = avg_message_length / 50.0
    end
    gnarling
  end

  def color
    
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
