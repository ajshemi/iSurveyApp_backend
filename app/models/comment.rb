class Comment < ApplicationRecord
  belongs_to :user
  validates :user_comment, length: { in: 15..200 }
  # validates :user_comment, format: { with: /\A[a-zA-Z]+\z/}
  default_scope lambda {order("created_at desc")}


end
