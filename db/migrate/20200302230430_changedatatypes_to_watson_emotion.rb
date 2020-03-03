class ChangedatatypesToWatsonEmotion < ActiveRecord::Migration[6.0]
  def change
    change_column :watson_emotions,:sadness,:float
    change_column :watson_emotions,:joy,:float
    change_column :watson_emotions,:fear,:float
    change_column :watson_emotions,:disgust,:float
    change_column :watson_emotions,:anger,:float
  end
end
