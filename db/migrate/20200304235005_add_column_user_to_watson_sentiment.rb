class AddColumnUserToWatsonSentiment < ActiveRecord::Migration[6.0]
  def change
    add_column :watson_sentiments,:user_id,:integer
  end
end
