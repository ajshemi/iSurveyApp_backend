class ChangescoretypeToWatsonSentiment < ActiveRecord::Migration[6.0]
  def change
    change_column :watson_sentiments,:score,:float
  end
end
