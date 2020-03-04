class AddColumnCommentToWatsonEmotion < ActiveRecord::Migration[6.0]
  def change
    add_column :watson_emotions,:comment_id,:integer
  end
end
