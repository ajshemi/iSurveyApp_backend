class AddColumnCommentToWatsonSentiment < ActiveRecord::Migration[6.0]
  def change
    add_column :watson_sentiments,:comment_id,:integer
  end
end
