class ProductSerializer < ActiveModel::Serializer
  attributes :product_id, :name, :ingredients
  # has_many :reviews
  def product_id
    self.object.id
  end
end
