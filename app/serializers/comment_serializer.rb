class CommentSerializer < ActiveModel::Serializer
  attributes :comment_id, :feedback
  # has_one :user
  def comment_id
    self.object.id
  end
end
