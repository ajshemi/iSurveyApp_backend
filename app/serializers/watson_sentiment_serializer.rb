class WatsonSentimentSerializer < ActiveModel::Serializer
  attributes :id, :score, :label
end
