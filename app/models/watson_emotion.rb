class WatsonEmotion < ApplicationRecord
    belongs_to :comment
    belongs_to :user
    # def user_id
    #     Comment.find_by(id: self.comment_id).user.id
    # end
end
