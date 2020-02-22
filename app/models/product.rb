class Product < ApplicationRecord
    has_many :reviews
    has_many :users, through: :reviews

    serialize :ingredients, Array 
end
