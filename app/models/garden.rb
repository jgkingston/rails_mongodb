class Garden
  include Mongoid::Document

  embedded_in :user
  embeds_many :growth_rings
  
  field :name, type: String
  field :last_sync, type: DateTime
  field :sha_keys, type: Array

end
