class WatsonEmotionSerializer < ActiveModel::Serializer
  attributes :id,:user_id,:comment_id,:sadness, :joy, :fear, :disgust, :anger

  # def user_id
  #   Comment.find_by(id: self.object.comment_id).user.id
  # end
end
