class GrowthRing
  include Mongoid::Document

  embedded_in :garden

  field :sha, type: String
  field :total, type: Integer
  field :additions, type: Integer
  field :deletions, type: Integer
  field :message, type: String

end
