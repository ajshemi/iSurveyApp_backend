class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :ingredients
  # has_many :reviews

end
