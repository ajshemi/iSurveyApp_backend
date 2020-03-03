class CreateWatsonSentiments < ActiveRecord::Migration[6.0]
  def change
    create_table :watson_sentiments do |t|
      t.integer :score
      t.string :label

      t.timestamps
    end
  end
end
