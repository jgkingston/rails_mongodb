class Garden
  include Mongoid::Document

  embedded_in :user
  embeds_many :growth_rings
  
  field :owner, type: String
  field :name, type: String
  field :sha_keys, type: Array
  field :sha_key_dates, type: Hash
  field :last_updated, type: DateTime, default: "2008-04-01T00:00:00Z"

  def age
    age = 0
    if self.growth_rings.length > 0
      growth_rings = self.growth_rings.length
      age = Math.log2(growth_rings).round
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
    
    if messages_lengths.size > 0
      avg_message_length =  messages_lengths.reduce(:+) / messages.length
      gnarling = avg_message_length / 50.0
    else
      gnarling = 1
    end
    gnarling
  end

end
