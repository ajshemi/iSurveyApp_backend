class UserSerializer < ActiveModel::Serializer
  attributes :id ,:username,:comment, :user_ratings
  # has_many :reviews
  # has_one :comment

  def comment
    CommentSerializer.new(self.object.comment)
  end

  # def comment
  #   CommentSerializer.new(self.object.comment)
  # end

  # def user_id
  #   self.object.id
  # end

  def user_ratings
    self.object.reviews.map do |review|
      ProductSerializer.new(review.product).as_json.merge({review_id: review.id, rating: review.rating})
      # ({product_id:review.product.id}).as_json.merge({review_id: review.id, rating: review.rating})

    end
  end



end
