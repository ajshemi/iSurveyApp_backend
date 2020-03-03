class WatsonEmotionSerializer < ActiveModel::Serializer
  attributes :id, :sadness, :joy, :fear, :disgust, :anger
end
