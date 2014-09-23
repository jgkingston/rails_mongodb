class Garden
  include Mongoid::Document

  embedded_in :user
  embeds_many :growth_rings
  
  field :name, type: String

end
