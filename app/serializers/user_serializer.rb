class UserSerializer < ActiveModel::Serializer
  attributes :id ,:username,:owned_reviews
  # has_many :reviews
  has_one :comment
  # def comment
  #   self.object.comment
  # end

  def owned_reviews
    self.object.reviews.map do |review|
      ProductSerializer.new(review.product).as_json.merge({review_id: review.id, rating: review.rating})
    end
  end

end
