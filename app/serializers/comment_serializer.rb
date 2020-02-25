class CommentSerializer < ActiveModel::Serializer
  attributes :id,:user_id, :user_comment
  # has_one :user
end
