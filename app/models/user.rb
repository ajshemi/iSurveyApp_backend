class User < ApplicationRecord
    has_secure_password   #before seeding your database
    validates_uniqueness_of :username
    validates :username,:password, presence: true
    has_many :reviews
    has_many :products, through: :reviews
    has_many :comments
    
    # def allcookies
    #     self.reviews.map{|element|Cookie.find_by(id: element.cookie_id)}
    # end
end
