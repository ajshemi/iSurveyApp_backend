class WatsonSentimentSerializer < ActiveModel::Serializer
  attributes :id,:user_id,:comment_id, :score, :label
  # def user_id
  #   Comment.find_by(id: self.object.comment_id).user.id
  # end
end
