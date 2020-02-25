class ChangeColumnFeedbackComments < ActiveRecord::Migration[6.0]
  def change
    rename_column :comments,:feedback,:user_comment
  end
end
