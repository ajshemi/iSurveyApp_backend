class ReviewSerializer < ActiveModel::Serializer
  attributes :review_id, :rating, :user_id, :product_id
  def review_id
    self.object.id
  end
end
