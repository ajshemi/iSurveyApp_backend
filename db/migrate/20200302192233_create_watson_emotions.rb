class CreateWatsonEmotions < ActiveRecord::Migration[6.0]
  def change
    create_table :watson_emotions do |t|
      t.integer :sadness
      t.integer :joy
      t.integer :fear
      t.integer :disgust
      t.integer :anger

      t.timestamps
    end
  end
end
