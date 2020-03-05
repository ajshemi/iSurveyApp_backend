class AddColumnUserToWatsonEmotion < ActiveRecord::Migration[6.0]
  def change
    add_column :watson_emotions,:user_id,:integer
  end
end
