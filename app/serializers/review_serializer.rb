class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :rating, :user_id, :product_id
end
